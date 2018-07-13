echo "Refresh:"
sudo cp /vagrant/varnish/override.conf /etc/systemd/system/varnish.service.d/override.conf && systemctl daemon-reload
sudo service varnish stop && sudo cp /vagrant/varnish/default.vcl /etc/varnish/default.vcl && sudo service varnish start