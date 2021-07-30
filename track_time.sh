mkdir -p $HOME/.track_time

categories=$(cat $HOME/.track_time/category.txt)
categoryUrlString=""
for i in $(echo $categories | tr ";" "\n")
do
    categoryUrlString=$categoryUrlString",<http://$(hostname -s)/track_time/category/$i>"
done

categoryUrlString=${categoryUrlString:1}

echo "<http://$(hostname -s)/track_time/timePoint/$(uuidgen)> <http://jvsoest.eu/ontology/timeTrack.owl#at_time> \"$(date '+%Y-%m-%dT%T')\"^^<http://www.w3.org/2001/XMLSchema#dateTime>; <http://jvsoest.eu/ontology/timeTrack.owl#hostname> <http://$(hostname -s)>; <http://jvsoest.eu/ontology/timeTrack.owl#category> $categoryUrlString." >> $HOME/.track_time/$(date '+%Y%m%d').ttl
