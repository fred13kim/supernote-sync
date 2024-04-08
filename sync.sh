#!/bin/bash

readonly MNT_PATH=/run/user/1000/gvfs/
readonly SUPERNOTE_MAIN=mtp://rockchip_Supernote_A5_X_SN100B30057390
readonly SUPERNOTE_PATH=mtp:host=rockchip_Supernote_A5_X_SN100B30057390/
readonly REPO_PATH=$HOME/repos/fred/notes/



while getopts 'acpsh' opt; do
    case "$opt" in
        a)
            if ls ${MNT_PATH} | grep "Supernote" > /dev/null
            then
                echo "${SUPERNOTE_MAIN} has been mounted"
            else
                echo "${SUPERNOTE_MAIN} has not been mounted, attempting to mount"
                gio mount ${SUPERNOTE_MAIN}
            fi

            if [ $? -ne 0 ]
            then
                echo "Something went wrong with mounting, exiting"
                exit 1
            fi
            rsync -avz "${MNT_PATH}${SUPERNOTE_PATH}Supernote/" "${REPO_PATH}Supernote"

            git -C ${REPO_PATH} add .
            ;;
        c)
            DATE=$(date)
            git -C ${REPO_PATH} commit -m "update as of ${DATE}"
            ;;
        p)
            git -C ${REPO_PATH} push
            ;;
        s)
            git -C ${REPO_PATH} status
            ;;
        ?|h)
            echo "USAGE: $(basename $0) [-a] [-c] [-p] [-s]"
            exit 1
            ;;
    esac
done

#push to repo

#push to note
#for directory in "${REPO_PATH}Supernote/"*
#do
#    if [ -n "$(ls -A ${directory})" ]
#    then
#        cp -R "${REPO_PATH}Supernote/${directory##*/}/"* "${MNT_PATH}${SUPERNOTE_PATH}Supernote/${directory##*/}/"
#    fi
#done


#git -C ${REPO_PATH} status

# wait 1 second to ensure the mounting process has succeeded
#gio mount -u ${SUPERNOTE_MAIN}
