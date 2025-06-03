CKA
==============

CKA 자격증 준비

# 환경 구성
* Packer
    * AMI 빌드 설정
    * 테스트 후 리소스 정리할 때 AMI 등록 해제 및 스냅샷 삭제 필요
        * `aws ec2 deregister-image --image-id <AMI ID>`
        * `aws ec2 delete-snapshot --snapshot-id <SNAPSHOT ID>`
* Terraform
    * 인스턴스 구성
