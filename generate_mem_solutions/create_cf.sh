for f in guppi_*cal*.fits
do
    filename=${f%.*s}.cf
    psradd -j 'fix refmjd' -J ../update_be_delay.psrsh -J ../img_guppi -J ../zap_and_tscrunch_with_list_gb -j "e rcvr:name=`../fix_receiver_name $f`" -j "e name=`../get_proper_name $f`" -o $filename $f
done
