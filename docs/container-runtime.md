k8s 환경에서 컨테이너 런타임
===========================

## 정의
* 노드 내에서 컨테이너를 실행할 수 있는 환경

## 용어
* CRI(Container Runtime Interface): 노드 내에서 컨테이너를 관리하는 kubelet과 컨테이너 런타임 간 통신하기 위한 표준 인터페이스(API)

## 요약
* 과거에는 쿠버네티스의 기본 컨테이너 런타임으로 docker를 사용하고 있었음
* kubelet이 docker 런타임에서 실행한 컨테이너와 통신하기 위해서는 CRI 표준을 준수하는 dockershim이 필요했었음.
* 그런데 docker 런타임에서 컨테이너를 실행하다 보니 여러가지 문제점이 있었음.

1. dockershim 관리 리스크
    - 쿠버네티스의 프로젝트중 하나였던 dockershim 유지보수가 어려움
    - 지속적인 docker 업데이트에 맞춰 dockershim도 업데이트를 적용해야하는 관리의 어려움
2. 불필요한 리소스 사용
    - 컨테이너 실행/중지/삭제 정도만 필요한데 docker는 빌드/푸시 등 기능도 포함하고 있어 불필요하게 리소스를 사용하게 됨.

* 그래서 쿠버네티스에서 dockershim을 제거하고 기존에 docker에 포함되어 있던 containerd만 따로 분리하여 이를 기본 컨테이너 런타임으로 채택하게 됨.
* containerd의 구성요소
    * containerd: 컨테이너 이미지 pull, 컨테이너 상태 추적, 로그 관리 등 high-level 기능 제공
    * runc: 실제로 리눅스 커널 기능(cgroup, namespace 등)을 사용해 컨테이너를 실행/중지/삭제하는 low-level 런타임
