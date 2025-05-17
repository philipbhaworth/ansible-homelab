# Homelab Ansible Repository

This repository contains Ansible automation for my homelab infrastructure, focusing on management of Kubernetes clusters and utility servers.

## Overview

This project is part of my journey learning Ansible for infrastructure automation. It currently manages:

- Kubernetes development and production clusters
- Jump hosts for secure access
- Configuration management and standardization

## Repository Structure

```
ansible/
├── ansible.cfg           # Ansible configuration
├── inventory.ini         # Inventory of all managed hosts
├── files/                # Static files for deployment
│   ├── .tmux.conf        # Terminal multiplexer config
│   ├── .vimrc            # Vim editor config
│   ├── personal/         # Personal environment dotfiles
│   └── utility/          # Minimal dotfiles for servers
├── playbooks/            # Ansible playbooks
    ├── ansible_user_bootstrap.yml  # Create ansible user on new hosts
    ├── dotfiles_personal.yml       # Deploy personal dotfiles
    ├── dotfiles_utility.yml        # Deploy minimal dotfiles
    └── ubu_svr_bootstrap.yml       # Ubuntu server initial setup
```

## Inventory Groups

- `jump`: Jump servers for secure access
- `k8_dev_nodes`: Kubernetes development cluster nodes
- `k8_prod_nodes`: Kubernetes production cluster nodes
- `all_nodes`: Parent group containing all hosts

## Usage Examples

### Bootstrap a new server:
```bash
ansible-playbook playbooks/ansible_user_bootstrap.yml --limit new_servers --ask-pass --ask-become-pass
```

### Update all production servers:
```bash
ansible-playbook playbooks/ubu_svr_bootstrap.yml --limit k8_prod_nodes
```

### Deploy dotfiles to specific hosts:
```bash
ansible-playbook playbooks/dotfiles_utility.yml --limit k8_dev_nodes
```

### Check connectivity to all hosts:
```bash
ansible all -m ping
```

## Prerequisites

- Ansible 2.9+
- SSH access to target hosts
- Python 3.6+ on managed hosts

## Future Plans

- Implement roles for common functionality
- Add variable organization with group_vars and host_vars
- Create a comprehensive site.yml entry point
- Add Kubernetes-specific automation

## Notes

This is a learning project that follows Ansible best practices. The repository structure and playbooks will evolve as I gain more experience.
