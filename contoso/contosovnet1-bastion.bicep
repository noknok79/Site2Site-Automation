@description('Specifies the location for resources.')
param location string = 'eastus'

param publicIPAddresses_contosovnet1_bastion_name string = 'contosovnet1-bastion'

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
