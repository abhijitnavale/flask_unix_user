#! /bin/sh -
PROGNAME=$0

usage() {
  cat << EOF >&2
Usage: $PROGNAME [-L] [-S] [-C] [-D <username>] [-r]

-L : List all existing users, except self
-S : Return username of current user
-C : create user (TODO)
-D <username> : Delete <username>
-r : remove home directory of user while deleting that user
EOF
  exit 1
}

deleteuser() {
    echo "Deleting user $1"
    echo $LOGINPASSWORD | sudo -S $@
    return 0
}
finalcommand=" "
user_action="create"

while getopts :LSC:D:r opt; do
  case $opt in
    (L) cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1
        exit 0
        ;;
    (S) whoami
        exit 0
        ;;
    (C) user_action="create"
        ;;
    (D) user_action="delete"
        finalcommand="userdel $OPTARG"
        ;;
    (r) r=" -r"
        finalcommand="$finalcommand $r"
        ;;
    (*) usage
      exit 1
      ;;
  esac
done
# shift "$((OPTIND - 1))"
# echo "Final Command"
# echo $finalcommand

if user_action=="delete"
then
    deleteuser $finalcommand
else
    createuser $finalcommand
fi

# echo Remaining arguments: "$@"
#sudo useradd -d '/home/test1' -e 2017-12-31 -f 0 -o 1234 -U test1
# sudo change -d 0 test1
