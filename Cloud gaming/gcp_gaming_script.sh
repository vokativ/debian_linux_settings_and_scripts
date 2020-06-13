#Define your gaming templates and disks
PREEMTIBLE_TEMPLATE="nemanja-i-preemtible-template"
FULL_PRICE_TEMPLATE="nemanja-i-stable-template-1"
DISK_NAME="parsec-test" #same name for the VM and disk to keep it simpler
ZONE="asia-southeast1-b"

#Get the latest snapshot
EXISTING_SNAPSHOT=$(gcloud compute snapshots list --sort-by=date | tail -1 | cut -d " " -f1)
printf "Latest snapshot is $EXISTING_SNAPSHOT\n"

###Create a machine or save and delete?
printf "\n\nDo you want to:\n1) Create a gaming VM or \n2) Save and delete a gaming VM?\nNeed to know for proper commands: "
read -r CREATE_SAVE
  if [ "$CREATE_SAVE" == 1 ]; then #create a gaming VM
          printf "\n\nCreating a new gaming VM\n"
          printf "\n\nDo you want to start \n1) Preemptible VM (cheaper) or \n2) Stable VM (full price, but won't turn off without your command)?\nNeed to know for proper commands: "
          read -r PREEMTIBLE_OR_FULL_PRICE

          if [ "$PREEMTIBLE_OR_FULL_PRICE" == 1 ]; then
            ### create and start the instance based on preemtible template and the last snapshot
            printf "Building the gaming machine based on snapshot $EXISTING_SNAPSHOT\n"
            gcloud compute instances create $DISK_NAME\
             --zone=$ZONE\
             --source-instance-template $PREEMTIBLE_TEMPLATE\
             --source-snapshot=$EXISTING_SNAPSHOT\
             --boot-disk-size 2048\
             --boot-disk-device-name $DISK_NAME
           elif [ "$PREEMTIBLE_OR_FULL_PRICE" == 2 ]; then
              ### create and start the instance based on preemtible template and the last snapshot
              printf "Building the gaming machine based on snapshot $EXISTING_SNAPSHOT\n"
              gcloud compute instances create $DISK_NAME\
               --zone=$ZONE\
               --source-instance-template $FULL_PRICE_TEMPLATE\
               --source-snapshot=$EXISTING_SNAPSHOT\
               --boot-disk-size 2048\
               --boot-disk-device-name $DISK_NAME
            else
                printf "Don't be a smart ass\n"
          fi

          #Define a zone for the disk to avoid prompts to pick a zone
          gcloud compute disks update $DISK_NAME --clear-labels --zone=$ZONE
    elif [ "$CREATE_SAVE" == 2 ]; then #save a snapshot and delete expensive resources
          #Record time and date when you finished the session for snapshot naming
          DATE_TIME=$(date +%Y-%M-%d-%H-%M)

          ###create a new snapshot of the drive
          printf "Saving a snapshot of the disk for future use\n"
          printf "Indicator for snapshot will be $DATE_TIME\n"
          gcloud compute disks snapshot $DISK_NAME --snapshot-names=parsec-test-$DATE_TIME --storage-location=$ZONE

          ###Delete the gaming instance
          printf "Deleting the VM and the corresponding disk\n"
          gcloud compute instances delete $DISK_NAME

          ### Delete the old snapshot
          printf "Deleting the old snapshot $EXISTING_SNAPSHOT to save on costs\n"
          gcloud compute snapshots delete $EXISTING_SNAPSHOT
    fi
