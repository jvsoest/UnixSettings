mkdir -p $HOME/.track_time

echo "<http://$(hostname)/time/timePoint/$(uuidgen)> <http://jvsoest.eu/ontology/timeTrack.owl#at_time> \"$(date '+%Y-%m-%dT%T')\"^^<http://www.w3.org/2001/XMLSchema#dateTime>; <http://jvsoest.eu/ontology/timeTrack.owl#hostname> <http://$(hostname)>." >> $HOME/.track_time/$(date '+%Y%m%d').ttl