//not bulk
trigger MyTriggerNotBulk on Account(before insert) {
    Account a = Trigger.new[0];
    a.Description = 'New description';
}

//bulk
trigger MyTriggerBulk on Account(before insert) {
    for(Account a : Trigger.new) {
        a.Description = 'New description';
    }
}