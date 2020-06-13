#Define your gaming templates and disks
PREEMTIBLE_TEMPLATE="nemanja-i-preemtible-template"
FULL_PRICE_TEMPLATE="nemanja-i-stable-template-1"
DISK_NAME="parsec-test"
ZONE="asia-southeast1-b"

#Get the latest snapshot
EXISTING_SNAPSHOT=$(gcloud compute snapshots list --sort-by=date | tail -1 | cut -d " " -f1)
echo "Latest snapshot is $EXISTING_SNAPSHOT"

#Record time and date when you started the session for later snapshot naming
DATE_TIME=$(date +%Y-%M-%d-%H-%M)



### create and start the instance based on preemtible template and the last snapshot
echo "Building the gaming machine based on snapshot $EXISTING_SNAPSHOT"
gcloud compute instances create $DISK_NAME\
 --zone=$ZONE\
 --source-instance-template $PREEMTIBLE_TEMPLATE\
 --source-snapshot=$EXISTING_SNAPSHOT\
 --boot-disk-size 2048\
 --boot-disk-device-name $DISK_NAME
 
#Define a zone for the disk to avoid prompts to pick a zone
gcloud compute disks update $DISK_NAME --zone=$ZONE
 
###create a new snapshot of the drive
echo "Indicator for snapshot will be $DATE_TIME"
gcloud compute disks snapshot $DISK_NAME --snapshot-names=parsec-test-$DATE_TIME #--storage-location=asia-southeast1-b



###Delete the gaming instance
echo "Deleting the VM and the corresponding disk"
gcloud compute instances delete parsec-test

### Delete the old snapshot
gcloud compute snapshots delete $EXISTING_SNAPSHOT


