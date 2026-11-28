# ĐỀ TÀI 09: XÂY DỰNG MÔI TRƯỜNG MÁY CHỦ ẢO CHO DOANH NGHIỆP

* **Học phần:** Điện toán đám mây và Ảo hóa (`RIPT1304-20261-02`) – Học viện Công nghệ Bưu chính Viễn thông (PTIT)
* **Nhóm thực hiện:** Nhóm 9B


---

## 1. Danh sách thành viên và phân công nhiệm vụ

| Vai trò | Họ và tên | Mã sinh viên | Nhiệm vụ kỹ thuật phụ trách | Sản phẩm & Minh chứng chính |
| :--- | :--- | :---: | :--- | :--- |
| **SV1 (Nhóm trưởng)** | Nguyễn Chí Tâm | `B24DCCC241` | Quy hoạch tài nguyên (vCPU, RAM, Storage), thiết lập tiêu chí đo, thực nghiệm bắn tải & phân tích hiệu năng (KT2) | Báo cáo chung, Báo cáo cá nhân SV1, Biểu đồ & Bảng số liệu đối chiếu KT2 (`Hình C.8 – C.11c`) |
| **SV2** | Phạm Thế Mạnh | `B24DCCC194` | Cài đặt VMware Workstation, triển khai OS Ubuntu Server 22.04.5 LTS, cấu hình mạng tĩnh NAT (Netplan) & tường lửa UFW | Tệp cấu hình mạng Netplan, `configs/firewall/ufw_rules.txt`, Báo cáo cá nhân SV2 (`Hình C.1, C.2, C.6`) |
| **SV3** | Vũ Minh Hiếu | `B24DCCC121` | Cấu hình Web Server Nginx Multi Virtual Hosts (`company.local`, `internal.company.local`), phân quyền dịch vụ & script sao lưu tự động | `configs/nginx/*`, `scripts/backup_web.sh`, Báo cáo cá nhân SV3 (`Hình C.4, C.5, C.7`) |
| **SV4** | Trương Quốc Hải | `B24DCCC103` | Giám sát tài nguyên hệ thống thời gian thực (`htop`, `Task Manager`) & diễn tập sao lưu, phục hồi sự cố dịch vụ (KT3) | Dữ liệu giám sát tài nguyên, nhật ký diễn tập phục hồi KT3, Báo cáo cá nhân SV4 (`Hình C.12a, C.12b`) |

---

## 2. Phiên bản phần mềm và thông số hạ tầng

* **Máy chủ vật lý thực hành (Host):** Acer Aspire 5 (`Intel Core i5-13420H` 8 Cores / 12 Threads, `12 GB DDR4 RAM`, `512 GB NVMe SSD`), OS **Windows 11 64-bit**.
* **Phần mềm ảo hóa (Hypervisor Type-2):** VMware Workstation Pro `17.x` (Card mạng ảo `VMnet8` – Custom NAT `192.168.243.0/24`, Gateway `192.168.243.2`).
* **Hệ điều hành máy chủ ảo (Guest VM):** Ubuntu Server `22.04.5 LTS` (CLI Only, Kernel `5.15.0-198-generic`, IP tĩnh `192.168.243.100/24`).
  * *Cấu hình 1 (Baseline):* `1 vCPU`, `1024 MB RAM` (`921 MiB` thực nhận), đĩa ảo `20 GB SCSI` (Thin Provisioning).
  * *Cấu hình 2 (Nâng cấp):* `2 vCPU` (`1 Socket x 2 Cores`), `2048 MB RAM` (`1,88 GiB` thực nhận), đĩa ảo `20 GB SCSI` (Thin Provisioning).
* **Dịch vụ & Công cụ kiểm thử:** Nginx `1.18.0`, UFW `0.36.1`, OpenSSH Server, ApacheBench (`ab.exe` gói Apache `2.4.69` trên Windows), `htop` `3.0.5`.

---

## 3. Cấu trúc thư mục Repository & Hồ sơ nộp bài

```text
PTIT-Cloud-Nhom09-DeTai09/
├── configs/
│   ├── firewall/
│   │   └── ufw_rules.txt                 # Danh sách luật tường lửa UFW (Mở 22/TCP, 80,443/TCP)
│   ├── nginx/
│   │   ├── company.local                 # Virtual Host 1: Trang web công khai doanh nghiệp
│   │   ├── internal.company.local        # Virtual Host 2: Cổng thông tin nội bộ (UTF-8)
│   │   ├── default                       # Cấu hình mặc định Nginx
│   │   └── nginx.conf                    # Cấu hình lõi Nginx Web Server
│   └── windows_hosts_sample.txt          # Mẫu cấu hình phân giải tên miền cục bộ trên Windows
├── scripts/
│   └── backup_web.sh                     # Kịch bản Bash tự động đóng gói sao lưu Web & Nginx (.tar.gz)
├── logs/
│   └── system_info.txt                   # Thông tin hệ thống & dữ liệu đo gốc thực nghiệm
├── .gitignore                            # Loại trừ tệp máy ảo (.vmdk, .iso) và tệp nén dung lượng lớn
└── README.md                             # Tài liệu tổng quan, phân công và hướng dẫn vận hành
