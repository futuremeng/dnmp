# prometheus

https://www.cnblogs.com/sonyy/p/13157153.html

./services/prometheus/prometheus.yml

global:
  scrape_interval:     15s 
  evaluation_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
  - job_name: 'server'
    static_configs:
    - targets: ['node-exporter:9100']