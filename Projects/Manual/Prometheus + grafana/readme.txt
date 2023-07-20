# Update System Packages:

shell
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo apt update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Install Prometheus:

shell
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a new system user and group
sudo useradd --no-create-home --shell /bin/false prometheus

# Download and extract the Prometheus binaries
wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar xvfz prometheus-2.30.3.linux-amd64.tar.gz

# Move the extracted files to the appropriate directories
sudo mv prometheus-2.30.3.linux-amd64/{prometheus,promtool} /usr/local/bin/
mkdir /etc/prometheus
sudo mv prometheus-2.30.3.linux-amd64/{consoles,console_libraries} /etc/prometheus/

# Set ownership and permissions
sudo chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}
sudo chown -R prometheus:prometheus /etc/prometheus/{consoles,console_libraries}

# Create a Prometheus configuration file
sudo nano /etc/prometheus/prometheus.yml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In the prometheus.yml file, add the following basic configuration:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']


# Create Prometheus Systemd Service:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


shell
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo nano /etc/systemd/system/prometheus.service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Add the following content to the file:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=default.target
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Save the file and exit the editor.

# Configure Prometheus Directory and Start Service:

shell

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a directory for storing Prometheus data
sudo mkdir /var/lib/prometheus

# Set ownership and permissions
sudo chown prometheus:prometheus /var/lib/prometheus

# Start Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus

# Verify service status
sudo systemctl status prometheus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Install Grafana:

shell

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Add Grafana repository
sudo apt install -y apt-transport-https
sudo apt install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

# Update and install Grafana
sudo apt update
sudo apt install -y grafana
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Start and Enable Grafana Service:

shell

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo systemctl enable --now grafana-server

# Verify service status
sudo systemctl status grafana-server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Access Grafana Web Interface:
Open a web browser and visit http://localhost:3000. You should be able to access the Grafana login page.

# Log in to Grafana:

Username: admin
Password: The initial password is usually admin. You will be prompted to change it upon login.

# Configure Prometheus as a Data Source in Grafana:

Click on the configuration gear icon on the left sidebar.
Select "Data Sources".
Click on the "Add data source" button.
Choose "Prometheus" as the type.
Set the URL to http://localhost:9090.
Click "Save & Test" to verify the connection.