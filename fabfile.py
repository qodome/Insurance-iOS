# -*- coding: utf-8 -*-

from contextlib import contextmanager
import gzip
import json
import mimetypes
import os
import sys

from pip._vendor.distlib.compat import raw_input
import requests

from fabric.colors import blue, cyan, green, magenta, red, yellow
from fabric.context_managers import cd, hide, prefix, settings, path
from fabric.contrib.files import exists
from fabric.decorators import task, roles, parallel
from fabric.operations import local, run, sudo, put, get
from fabric.state import env
from fabric.tasks import execute
from fabric.utils import puts


"""手动配置"""
env.organization = 'xiaomar'
env.newrelic_key = '7cba721d377c66139fb07c29ecf1bae50e3dbf43'
env.git_host = ['GitHub', 'github.com']  # ['GitLab', 'gitlab.com']

# ===========
# = GLOBALS =
# ===========
env.project_name = os.path.basename(os.path.dirname(__file__))
env.project_path = '~/{0.git_host[0]}/{0.project_name}'.format(env)
# 其他:
env.repository = 'git@{0.git_host[1]}:qodome/{0.project_name}.git'.format(env)
env.cloud = 'aliyun'  # 可选: aws, aliyun
env.forward_agent = True  # GitHub的代理转发部署方式需要开启这项
env.colorize_errors = True

# ============
# =  Hello   =
# ============
@task(default=True, alias='别名测试')
def hello():
    puts('*' * 50)
    puts(cyan('  Fabric 使用指南\n'))
    puts(green('  查看所有命令: fab -l'))
    puts(green('  查看命令: fab -d 命令'))
    puts(yellow('  带参数命令请输入: fab 命令:参数'))
    puts(magenta('  手动配置env.(organization, newrelic_key, roledefs)'))
    puts(blue('  部署正式环境: fab prod deplay'))
    puts('  Project Name: {.project_name}'.format(env))
    puts('  Repository: {.repository}'.format(env))
    puts('*' * 50)


# =========
# =  git  =
# =========
@task
def commit_and_sync(comment=None):
    """git commit and sync"""
    output_list = local('git status', True).split('\n')
    branch = output_list[0].replace('On branch ', '')
    if branch in ['develop', 'master']:
        puts('不允许在 {} 分支 用 {} 命令直接操作'.format(yellow(branch), get_function_name()))
    elif 'nothing to commit' in output_list[-1]:
        puts('{} 分支没有变动, 不需要提交'.format(yellow(branch)))
        if 'is ahead of' in output_list[1]:
            puts('同步 {} 分支'.format(yellow(branch)))
            local_proxy('git push')
    else:
        local('git reset')
        delete_files = [x.strip() for x in output_list if x.find('deleted:') != -1]
        for file in delete_files:
            filename = file.split(':')[1].strip()
            local('git rm {}'.format(filename))
        local('git add .')
        if not comment:
            comment = raw_input('请输入提交的注解: ')
        local('git status')
        local('git commit -m "{}"'.format(comment))
        local_proxy('git push')


@task
def update_from_develop():
    """从 develop 更新到当前分支"""
    output_list = local('git status', True).split('\n')
    branch = output_list[0].replace('On branch ', '')
    if branch in ['develop', 'master']:
        puts('不允许在 {} 分支 用 {} 命令直接操作'.format(yellow(branch), get_function_name()))
    elif 'nothing to commit' in output_list[-1]:
        local_proxy('git pull origin develop')
        local_compilemessages()
    else:
        local('git status')
        puts('当前 {} 分支有更新未提交, 请先执行 fab git_commit 命令提交'.format(yellow(branch)))


@task
def update_to_develop():
    """从当前分支更新到 develop """
    output_list = local('git status', True).split('\n')
    branch = output_list[0].replace('On branch ', '')
    if branch in ['develop', 'master']:
        puts('不允许在 {} 分支 用 {} 命令直接操作'.format(yellow(branch), get_function_name()))
    elif 'nothing to commit' in output_list[-1]:
        confirm = raw_input('是否已经update_from_develop? [y/N]: '.format(yellow(branch)))
        if confirm.lower() in ['ok', 'y', 'yes']:
            puts('从 {} 合并到 develop'.format(yellow(branch)))
            local('git checkout develop')
            local_proxy('git pull')
            local('git merge {}'.format(branch))
            local_proxy('git push')
            local('git checkout {}'.format(branch))
    else:
        local('git status')
        puts('当前 {} 分支有更新未提交, 请先执行 fab git_commit 命令提交'.format(yellow(branch)))


# ============
# = 工具方法  =
# ============
def smartrun(command):
    with cd(env.project_path):
        run(command)


def smartputs(prefix):
    if env.host_string in env.roledefs['app']:
        sputs(prefix, green('【应用服务器】[{}]'.format(env.host_string)))
    else:
        sputs(prefix, magenta('🌵 【未知类型服务器】[{}]'.format(env.host_string)))


def sputs(prefix, text):
    puts(yellow(prefix) + ('【测试】' if env.test else '') + yellow('环境') + text + yellow(' --'), show_prefix=False)


def get_function_name():
    return sys._getframe(1).f_code.co_name  # _getframe()则是自己的名字
