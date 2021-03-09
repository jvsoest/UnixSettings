mkdir -p $HOME/.track_time

echo "<http://$(hostname)/track_time/timePoint/$(uuidgen)> <http://jvsoest.eu/ontology/timeTrack.owl#at_time> \"$(date '+%Y-%m-%dT%T')\"^^<http://www.w3.org/2001/XMLSchema#dateTime>; <http://jvsoest.eu/ontology/timeTrack.owl#hostname> <http://$(hostname)>; <http://jvsoest.eu/ontology/timeTrack.owl#category> <http://$(hostname)/track_time/category/$(cat $HOME/.track_time/category.txt)>." >> $HOME/.track_time/$(date '+%Y%m%d').ttl
