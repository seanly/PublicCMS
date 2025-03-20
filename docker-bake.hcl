variable "VERSION" {
  default = "V4.0"
}

variable "FIXID" {
  default = "1"
}

group "default" {
  targets = ["publiccms"]
}

target "publiccms" {
    labels = {
        "cloud.opsbox.author" = "seanly"
        "cloud.opsbox.image.name" = "publiccms"
        "cloud.opsbox.image.version" = "${VERSION}"
        "cloud.opsbox.image.fixid" = "${FIXID}"
    }
    dockerfile = "Dockerfile"
    context  = "./"
    args = {
        VERSION="${VERSION}"
    }
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [
        "seanly/appset:publiccms-${VERSION}-${FIXID}"
    ]
    output = ["type=image,push=true"]
}

variable "ACR_REGISTRY" {
  default = "registry.cn-chengdu.aliyuncs.com"
}

group "acr" {
  targets = ["publiccms-amd64", "publiccms-arm64"]
}

target "publiccms-amd64" {
    labels = {
        "cloud.opsbox.author" = "seanly"
        "cloud.opsbox.image.name" = "publiccms"
        "cloud.opsbox.image.version" = "${VERSION}"
        "cloud.opsbox.image.fixid" = "${FIXID}"
    }
    dockerfile = "Dockerfile"
    context  = "./"
    args = {
        VERSION="${VERSION}"
    }
    platforms = ["linux/amd64"]
    tags = [
        "${ACR_REGISTRY}/seanly/appset:publiccms-${VERSION}-${FIXID}",
        "${ACR_REGISTRY}/seanly/appset:publiccms-${VERSION}-${FIXID}-amd64"
    ]
    output = ["type=image,push=true"]
}

target "publiccms-arm64" {
    labels = {
        "cloud.opsbox.author" = "seanly"
        "cloud.opsbox.image.name" = "publiccms"
        "cloud.opsbox.image.version" = "${VERSION}"
        "cloud.opsbox.image.fixid" = "${FIXID}"
    }
    dockerfile = "Dockerfile"
    context  = "./"
    args = {
        VERSION="${VERSION}"
    }
    platforms = ["linux/arm64"]
    tags = [
        "${ACR_REGISTRY}/seanly/appset:publiccms-${VERSION}-${FIXID}-arm64"
    ]
    output = ["type=image,push=true"]
}
