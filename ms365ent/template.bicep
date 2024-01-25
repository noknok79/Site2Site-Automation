param virtualMachines_ms365entvm1_name string = 'ms365entvm1'
param virtualNetworks_ms365entvnet1_name string = 'ms365entvnet1'
param networkInterfaces_ms365entvm1478_name string = 'ms365entvm1478'
param publicIPAddresses_ms365entvm1_ip_name string = 'ms365entvm1-ip'
param bastionHosts_ms365entvnet1_Bastion_name string = 'ms365entvnet1-Bastion'
param networkSecurityGroups_ms365entvm1_nsg_name string = 'ms365entvm1-nsg'
param publicIPAddresses_ms365entvnet1_bastion_name string = 'ms365entvnet1-bastion'
param schedules_shutdown_computevm_ms365entvm1_name string = 'shutdown-computevm-ms365entvm1'

resource networkSecurityGroups_ms365entvm1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroups_ms365entvm1_nsg_name
  location: 'southeastasia'
  tags: {
    vm1: 'ms365ent'
  }
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_ms365entvm1_nsg_name_RDP.id
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
        id: networkSecurityGroups_ms365entvm1_nsg_name_SSH.id
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

resource publicIPAddresses_ms365entvm1_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_ms365entvm1_ip_name
  location: 'southeastasia'
  tags: {
    vm1: 'ms365ent'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '4.194.102.21'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_ms365entvnet1_bastion_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_ms365entvnet1_bastion_name
  location: 'southeastasia'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '4.194.126.112'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource virtualNetworks_ms365entvnet1_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_ms365entvnet1_name
  location: 'southeastasia'
  tags: {
    vnet: 'ms365ent'
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
        name: 'subnet1-ms365ent'
        id: virtualNetworks_ms365entvnet1_name_subnet1_ms365ent.id
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
        id: virtualNetworks_ms365entvnet1_name_AzureBastionSubnet.id
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
        id: virtualNetworks_ms365entvnet1_name_GatewaySubnet.id
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

resource virtualMachines_ms365entvm1_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_ms365entvm1_name
  location: 'southeastasia'
  tags: {
    vm1: 'ms365ent'
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
        name: '${virtualMachines_ms365entvm1_name}_OsDisk_1_b74a4fc838974739937149a2893c69c9'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_ms365entvm1_name}_OsDisk_1_b74a4fc838974739937149a2893c69c9')
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_ms365entvm1_name
      adminUsername: 'azureuser'
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
          id: networkInterfaces_ms365entvm1478_name_resource.id
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
  }
}

resource schedules_shutdown_computevm_ms365entvm1_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_ms365entvm1_name
  location: 'southeastasia'
  tags: {
    vm1: 'ms365ent'
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
    targetResourceId: virtualMachines_ms365entvm1_name_resource.id
  }
}

resource networkSecurityGroups_ms365entvm1_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  name: '${networkSecurityGroups_ms365entvm1_nsg_name}/RDP'
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
    networkSecurityGroups_ms365entvm1_nsg_name_resource
  ]
}

resource networkSecurityGroups_ms365entvm1_nsg_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2023-06-01' = {
  name: '${networkSecurityGroups_ms365entvm1_nsg_name}/SSH'
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
    networkSecurityGroups_ms365entvm1_nsg_name_resource
  ]
}

resource virtualNetworks_ms365entvnet1_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_ms365entvnet1_name}/AzureBastionSubnet'
  properties: {
    addressPrefix: '10.0.1.0/26'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_ms365entvnet1_name_resource
  ]
}

resource virtualNetworks_ms365entvnet1_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_ms365entvnet1_name}/GatewaySubnet'
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
    virtualNetworks_ms365entvnet1_name_resource
  ]
}

resource virtualNetworks_ms365entvnet1_name_subnet1_ms365ent 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  name: '${virtualNetworks_ms365entvnet1_name}/subnet1-ms365ent'
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
    virtualNetworks_ms365entvnet1_name_resource
  ]
}

resource bastionHosts_ms365entvnet1_Bastion_name_resource 'Microsoft.Network/bastionHosts@2023-06-01' = {
  name: bastionHosts_ms365entvnet1_Bastion_name
  location: 'southeastasia'
  tags: {
    vnet: 'ms365ent'
  }
  sku: {
    name: 'Basic'
  }
  properties: {
    dnsName: 'bst-2b760c11-89e2-4667-95f9-dc5a1b729127.bastion.azure.com'
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionHosts_ms365entvnet1_Bastion_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ms365entvnet1_bastion_name_resource.id
          }
          subnet: {
            id: virtualNetworks_ms365entvnet1_name_AzureBastionSubnet.id
          }
        }
      }
    ]
  }
}

resource networkInterfaces_ms365entvm1478_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_ms365entvm1478_name
  location: 'southeastasia'
  tags: {
    vm1: 'ms365ent'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_ms365entvm1478_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"c5124f57-bdab-448f-9d1d-4f277d434900"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ms365entvm1_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_ms365entvnet1_name_subnet1_ms365ent.id
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
      id: networkSecurityGroups_ms365entvm1_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}