#!/usr/bin/env python
from subprocess import Popen, PIPE
from glob import iglob
from string import Template
import os, re, json, shutil

USER_INFO_KEYS = ['name', 'email']

def get_git_root():
  git_root_cmd = Popen(['git', 'rev-parse', '--show-toplevel',], stdout=PIPE,
      cwd=os.path.dirname(__file__))
  git_root_cmd.wait()
  stdout, stderr = git_root_cmd.communicate()

  return stdout.rstrip()

def process_symlinks(git_root, home_dir):
  comment_reg = re.compile(r'^\s*#|^\s*$')
  valid_reg = re.compile(r'^(\S+)\s+(\S+)$')

  valid_reg = re.compile(r'(.*?)(\.gen)?\.dot')

  for link_src in iglob(os.path.join(git_root,'*.dot')):
    match = valid_reg.match(os.path.basename(link_src))
    if match:
      link_target = os.path.join(home_dir,'.' + match.group(1))
      if os.path.exists(link_target):
        if os.path.islink(link_target):
          os.unlink(link_target)
        else:
          user_answer = ""
          while 1:
            if user_answer == "Y":
              os.rename(link_target, link_target+".back")
              print "Backup created %s" % (link_target+".back",)
              break
            elif user_answer == "N":
              if os.path.isdir(link_target):
                shutil.rmtree(link_target)
              else:
                os.unlink(link_target)
              break
            else:
              user_answer = raw_input(
                  "Target '%s' exists create backup (Y/N):" % (link_target,) )
      os.symlink(link_src, link_target)
      print "Created Link", link_src, "=>", link_target

    else:
      print "Parse error skipping file '%s'" % (link_src,)

def write_user_info(user_info_file_loc, user_info):
  user_info_file = open(user_info_file_loc, 'w')
  user_info_file.write(
      json.dumps(user_info, sort_keys=True, indent=2, separators=(', ', ': ')))
  user_info_file.close()

def read_user_info(user_info_file_loc):
  if os.path.exists(user_info_file_loc):
    user_info_file = open(user_info_file_loc, 'r')
    user_info = json.load(user_info_file)
    user_info_file.close()
  else:
    user_info = dict()
  return user_info

def get_user_info(git_root, home):
  user_info_file_loc = os.path.join(git_root, 'user_info')

  user_info = read_user_info(user_info_file_loc)

  user_info['GIT_ROOT'] = git_root
  user_info['HOME'] = home

  for key in USER_INFO_KEYS:
    if not key in user_info:
      user_info[key] = ""
      while 1:
        if user_info[key] == "":
          user_info[key] = raw_input("Please enter your %s: " 
              % (key, )).strip()
        else:
          break

  write_user_info(user_info_file_loc, user_info)

  return user_info

def build_dot_files_from_templates(git_root, user_info):
  for template_loc in iglob(os.path.join(git_root, '*.template')):
    template_file = open(template_loc, 'r')
    template = Template(template_file.read())
    template_file.close()

    gen_loc = template_loc.rsplit('.', 1)[0] + '.gen.dot'
    gen_file = open(gen_loc, 'w')
    gen_file.write(template.substitute(user_info))
    print "Generated %s => %s" % (template_loc, gen_loc)

def main():
  GIT_ROOT = get_git_root()
  HOME = os.path.expanduser('~')

  user_info = get_user_info(GIT_ROOT, HOME)

  for key in user_info.keys():
    print "%s: %s" % (key, user_info[key])

  print "" # Blank line

  build_dot_files_from_templates(GIT_ROOT, user_info)

  # TODO(will): create get hook
  process_symlinks(GIT_ROOT, HOME)

if __name__ == '__main__':
  main()
