rm /var/portage/distfiles/sendxmpp*
rm Manifest
rm files/*
for file in *.ebuild;
do
	ebuild $file digest
done
