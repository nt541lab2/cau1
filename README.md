# Triển khai hạ tầng AWS với Terraform và GitHub Actions

## Mô tả
Dự án này sử dụng **Terraform** để triển khai các tài nguyên AWS, bao gồm:
- **VPC**: Cấu hình mạng riêng với các subnet public và private.
- **Route Tables**: Định tuyến lưu lượng mạng.
- **NAT Gateway**: Cho phép các instance trong private subnet truy cập Internet.
- **EC2**: Triển khai máy ảo EC2 trong VPC.
- **Security Groups**: Quy tắc bảo mật để kiểm soát lưu lượng vào/ra.

Dự án tích hợp:
- **GitHub Actions**: Tự động hóa quy trình CI/CD (terraform init, plan, apply).
- **Checkov**: Kiểm tra bảo mật mã nguồn Terraform để đảm bảo tuân thủ best practices.

Mục đích: Cung cấp một hạ tầng mẫu cho môi trường phát triển hoặc thử nghiệm, với quy trình triển khai tự động và kiểm tra bảo mật.

## Yêu cầu tiên quyết
- Tài khoản AWS với quyền tạo VPC, EC2, NAT Gateway.
- Cài đặt các công cụ:
  - [Terraform](https://www.terraform.io/downloads.html) (phiên bản >= 1.5.0).
  - [AWS CLI](https://aws.amazon.com/cli/) (đã cấu hình credentials).
  - [Checkov](https://www.checkov.io/) (để kiểm tra bảo mật local, tùy chọn).
- Tài khoản GitHub và quyền admin để cấu hình GitHub Secrets.
```

## Hướng dẫn triển khai

### 1. Clone repository
```bash
git clone https://github.com/nt541lab2/cau1.git
cd cau1
```

### 2. Cấu hình Terraform (local, tùy chọn)
Kiểm tra mã nguồn Terraform trước khi push:
```bash
terraform init
terraform validate
terraform plan
```

Kiểm tra bảo mật với Checkov:
```bash
checkov -d .
```

### 3. Cấu hình GitHub Actions
1. Trong GitHub repository, vào **Settings > Secrets and variables > Actions**.
2. Thêm các secrets sau:
   - `AWS_ACCESS_KEY_ID`: Access Key của IAM user.
   - `AWS_SECRET_ACCESS_KEY`: Secret Key của IAM user.

   **Lưu ý**: Để tăng cường bảo mật, nên sử dụng **AWS OIDC** hoặc **IAM Roles** thay vì lưu trữ credentials trực tiếp. Xem [hướng dẫn AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html).

### 4. Tự động hóa với GitHub Actions
- Workflow được định nghĩa trong `.github/workflows/terraform.yml`.
- Mỗi khi push code hoặc tạo pull request, workflow sẽ:
  1. Chạy **Checkov** để kiểm tra bảo mật.
  2. Thực hiện `terraform init`, `terraform plan`, và `terraform apply` (nếu được phê duyệt).
- Kiểm tra kết quả trong tab **Actions** của GitHub repo.

### 5. Hủy tài nguyên
Để tránh chi phí không mong muốn, hủy tài nguyên sau khi sử dụng:
```bash
terraform destroy
```

## Xử lý sự cố
- **Workflow thất bại**: Xem log chi tiết trong tab **Actions** trên GitHub.
- **Lỗi Terraform**: Kiểm tra cú pháp trong `main.tf` hoặc quyền IAM của AWS credentials.
- **Checkov báo lỗi**: Xem báo cáo Checkov trong log để sửa các vấn đề bảo mật.