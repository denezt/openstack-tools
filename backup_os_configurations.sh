#!/bin/bash

os_main_bkup="/mnt/os_backups"
_components=( nova neutron cinder keystone glance swift horizon heat ceilometer trove )

error(){
	printf "\33[35mError:\t\033[31m${1}\033[0m\n"
	exit 1
}

create_archive_dirs(){
	component="${1}"
	if [ -n "${component}" ];
	then
		[ ! -d "${os_main_bkup}" ] && sudo mkdir -v "${os_main_bkup}"
		[ ! -d "${os_main_bkup}/${component}" ] && sudo mkdir -vp "${os_main_bkup}/${component}" && \
		printf "Successfully, created ${os_main_bkup}/${component}!\n" || \
		printf "Archive Directory was already created: ${os_main_bkup}/${component}\n"
		ls "${os_main_bkup}/${component}"
	else
		error "Missing or invalid component was given"
	fi
}

create_backup_archive(){
	component="${1}"
	if [ -n "${component}" ];
	then
		if [ -d "/etc/${component}" ];
		then
			sudo cp -a -v "/etc/${component}" "${os_main_bkup}/${component}" && \
			printf "Successfully, created ${os_main_bkup}/${component} archive!\n"
			ls -r "${os_main_bkup}/${component}"
		fi
	else
		error "Missing or invalid component was given"
	fi
}

for component in ${_components[*]};
do
	printf "${component}\n"
	create_archive_dirs "${component}"
	create_backup_archive "${component}"
done
