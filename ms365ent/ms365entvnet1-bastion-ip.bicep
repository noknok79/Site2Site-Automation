@description('Specifies the location for resources.')
param location string = 'southeastasia'

param publicIPAddresses_ms365entvnet1_bastion_name string = 'ms365entvnet1-bastion'

resource publicIPAddresses_ms365entvnet1_bastion_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_ms365entvnet1_bastion_name
  location: location
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
