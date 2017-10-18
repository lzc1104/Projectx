//
//  DNSServiceType.swift
//  Pods
//
//  Created by 王小涛 on 2017/8/14.
//
//

import Foundation

//HTTPDNS 场景下兼容 IPv6-only 网络环境需要注意的细节：
//
//当您使用 IP 形式的 URL 进行网络请求时，IPv4 与 IPv6 的 IP 地址使用方式略有不同：
//
//IPv4: http://1.1.1.1/path
//IPv6: http://[2001:db8:c000:221::]/path
//即在URL中使用IPv6地址时需要在IPv6地址基础上额外加上[]。为了方便开发者的使用，HTTPDNS提供了适配URL格式的IP获取接口 -[HttpDnsService getIpByHostAsyncInURLFormat:]。当您通过HTTPDNS进行IP获取，并使用该IP进行基于URL的网络访问时，您可以通过上述API直接获取符合URL使用场景，格式化后的IP信息，如1.1.1.1，[2001:db8:c000:221::]。如果您仅仅为了获取精准的IP信息并另做它用，您可以继续使用老接口 -[HttpDnsService getIpByHostAsync:]。
// 参考：https://help.aliyun.com/document_detail/30141.html?spm=5176.2020520107.0.0.719a83832DntYu

public protocol DNSServiceType: class {
    func resolve(host: String) -> String?   // 返回
    func resolveInURLFormat(host: String) -> String? // http://[xxx,xxx]/api
}
