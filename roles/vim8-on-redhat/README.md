---

Galaxy_name: punit-vim8
Github_user: punit144
Github_name: Project-Ansible/role/punit-vim8
Badges: |
  [![GitHub Tags](https://github.com/punit144/Project-Ansible.git)]
Description: |
  > * Check old versions of vim and removes them but not vim-minimal as it is
      needed for sudo.
  > * Download vim from github (latest)
  > * Download all dependencies required to build vim 8 on RedHat/Centos 7/8.
  > * Build vim for binaries downloaded to your home directory.
  > * configure vim globally for all users with below github plugins.
  > * pathogen in /.vim/autoload for loading plugins.
  > * below plugins inside ~/.vim/bundle
    - vim-arline
    - ctrlp
    - gruvbox
    - vim-arline-themes
    - molokai
    - simplyfold
    - nerdtree
    - Zenburn
Requirements:
  - python 2.5+
  - ansible 2.2+
  - sudo rights
  - internet access to download and perform package installation on host.

