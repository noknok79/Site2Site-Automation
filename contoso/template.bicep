@description('Specifies the location for resources.')
param location string = 'eastus'
param adminUsernameParam string = 'azureuser'

param virtualMachines_contosovm1_name string = 'contosovm1'
param publicIPAddresses_publicip2_name string = 'publicip2'
param publicIPAddresses_publicip3_name string = 'publicip3'
param virtualNetworks_contosovnet1_name string = 'contosovnet1'
param networkInterfaces_contosovm1402_name string = 'contosovm1402'
param publicIPAddresses_contosovm1_ip_name string = 'contosovm1-ip'
param bastionHosts_contosovnet1_Bastion_name string = 'contosovnet1-Bastion'
param localNetworkGateways_contosolocgw_name string = 'contosolocgw'
param connections_s2s_connect_to_ms365ent_name string = 's2s-connect-to-ms365ent'
param networkSecurityGroups_contosovm1_nsg_name string = 'contosovm1-nsg'
param publicIPAddresses_contosovnet1_bastion_name string = 'contosovnet1-bastion'
param virtualNetworkGateways_contosovirtnetgw_name string = 'contosovirtnetgw'
param schedules_shutdown_computevm_contosovm1_name string = 'shutdown-computevm-contosovm1'

resource localNetworkGateways_contosolocgw_name_resource 'Microsoft.Network/localNetworkGateways@2023-06-01' = {
  name: localNetworkGateways_contosolocgw_name
  location: location
  properties: {
    localNetworkAddressSpace: {
      addressPrefixes: [
        '192.168.0.0/24'
        '172.16.0.0/24'
      ]
    }
    gatewayIpAddress: '4.194.102.21'
  }
}

resource networkSecurityGroups_contosovm1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroups_contosovm1_nsg_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  properties: {
    securityRules: [
      {
        name: 'RDP'
        //id: networkSecurityGroups_contosovm1_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'SSH'
        //id: networkSecurityGroups_contosovm1_nsg_name_SSH.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 320
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_contosovm1_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_contosovm1_ip_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.169.134.86'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_contosovnet1_bastion_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_contosovnet1_bastion_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '172.206.207.120'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource publicIPAddresses_publicip2_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_publicip2_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.120.5.233'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_publicip3_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_publicip3_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.115.15.123'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_contosovnet1_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_contosovnet1_name
  location: location
  tags: {
    vnet: 'contoso'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'subnet1-contoso'
        //id: virtualNetworks_contosovnet1_name_subnet1_contoso.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/27'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        //id: virtualNetworks_contosovnet1_name_AzureBastionSubnet.id
        properties: {
          addressPrefix: '10.0.1.0/26'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'GatewaySubnet'
        //id: virtualNetworks_contosovnet1_name_GatewaySubnet.id
        properties: {
          addressPrefixes: [
            '10.0.0.32/27'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachines_contosovm1_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_contosovm1_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition-hotpatch'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_contosovm1_name}_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_contosovm1_name}_OsDisk_1_8c2c78cabbab408fa190353d86b1fc56')
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_contosovm1_name
      adminUsername: adminUsernameParam
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByPlatform'
          automaticByPlatformSettings: {
            rebootSetting: 'IfRequired'
            bypassPlatformSafetyChecksOnUserSchedule: false
          }
          assessmentMode: 'ImageDefault'
          enableHotpatching: true
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          //id: networkInterfaces_contosovm1402_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Server'
  }
}

resource schedules_shutdown_computevm_contosovm1_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_contosovm1_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '1900'
    }
    timeZoneId: 'UTC'
    notificationSettings: {
      status: 'Enabled'
      timeInMinutes: 30
      emailRecipient: 'nokiev@yahoo.com'
      notificationLocale: 'en'
    }
    targetResourceId: virtualMachines_contosovm1_name_resource.id
  }
}

resource networkSecurityGroups_contosovm1_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  parent: networkSecurityGroups_contosovm1_nsg_name_resource
  name: 'RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    //networkSecurityGroups_contosovm1_nsg_name_resource
  ]
}

resource networkSecurityGroups_contosovm1_nsg_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  parent: networkSecurityGroups_contosovm1_nsg_name_resource
  name: 'SSH'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 320
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    //networkSecurityGroups_contosovm1_nsg_name_resource
  ]
}

resource virtualNetworks_contosovnet1_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefix: '10.0.1.0/26'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    //virtualNetworks_contosovnet1_name_resource
  ]
}

resource virtualNetworks_contosovnet1_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
  name: 'GatewaySubnet'
  properties: {
    addressPrefixes: [
      '10.0.0.32/27'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    //virtualNetworks_contosovnet1_name_resource
  ]
}

resource virtualNetworks_contosovnet1_name_subnet1_contoso 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
  name: 'subnet1-contoso'
  properties: {
    addressPrefixes: [
      '10.0.0.0/27'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    //virtualNetworks_contosovnet1_name_resource
  ]
}

resource bastionHosts_contosovnet1_Bastion_name_resource 'Microsoft.Network/bastionHosts@2023-06-01' = {
  name: bastionHosts_contosovnet1_Bastion_name
  location: location
  tags: {
    vnet: 'contoso'
  }
  sku: {
    name: 'Basic'
  }
  properties: {
    dnsName: 'bst-9f590446-e8ae-45eb-b83d-b9fdfb0f1e04.bastion.azure.com'
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionHosts_contosovnet1_Bastion_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_contosovnet1_bastion_name_resource.id
          }
          subnet: {
            id: virtualNetworks_contosovnet1_name_AzureBastionSubnet.id
          }
        }
      }
    ]
  }
}

resource connections_s2s_connect_to_ms365ent_name_resource 'Microsoft.Network/connections@2023-06-01' = {
  name: connections_s2s_connect_to_ms365ent_name
  location: location
  tags: {
    connection: 'contoso'
  }
  properties: {
    virtualNetworkGateway1: {
      //id: virtualNetworkGateways_contosovirtnetgw_name_resource.id
      properties: {}
    }
    localNetworkGateway2: {
      id: localNetworkGateways_contosolocgw_name_resource.id
      properties: {}
    }
    connectionType: 'IPsec'
    connectionProtocol: 'IKEv2'
    routingWeight: 0
    sharedKey: 'm@rkV!09'
    enableBgp: false
    useLocalAzureIpAddress: false
    usePolicyBasedTrafficSelectors: false
    ipsecPolicies: []
    trafficSelectorPolicies: []
    expressRouteGatewayBypass: false
    enablePrivateLinkFastPath: false
    dpdTimeoutSeconds: 45
    connectionMode: 'Default'
    gatewayCustomBgpIpAddresses: []
  }
}

resource networkInterfaces_contosovm1402_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_contosovm1402_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_contosovm1402_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"d09ee52a-d5c6-43ee-92a6-26802398cb9d"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_contosovm1_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_contosovnet1_name_subnet1_contoso.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_contosovm1_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualNetworkGateways_contosovirtnetgw_name_resource 'Microsoft.Network/virtualNetworkGateways@2023-06-01' = {
  name: virtualNetworkGateways_contosovirtnetgw_name
  location: location
  tags: {
    virtualnetgw: 'contoso'
  }
  properties: {
    enablePrivateIpAddress: false
    ipConfigurations: [
      {
        name: 'default'
        id: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicip2_name_resource.id
          }
          subnet: {
            id: virtualNetworks_contosovnet1_name_GatewaySubnet.id
          }
        }
      }
      {
        name: 'activeActive'
        id: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/activeActive'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicip3_name_resource.id
          }
          subnet: {
            id: virtualNetworks_contosovnet1_name_GatewaySubnet.id
          }
        }
      }
    ]
    natRules: []
    virtualNetworkGatewayPolicyGroups: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: true
    bgpSettings: {
      asn: 65515
      bgpPeeringAddress: '10.0.0.37,10.0.0.36'
      peerWeight: 0
      bgpPeeringAddresses: [
        {
          ipconfigurationId: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/default'
          customBgpIpAddresses: []
        }
        {
          ipconfigurationId: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/activeActive'
          customBgpIpAddresses: []
        }
      ]
    }
    vpnGatewayGeneration: 'Generation1'
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}
