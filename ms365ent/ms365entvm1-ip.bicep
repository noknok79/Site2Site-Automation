@description('Specifies the location for resources.')
param location string = 'southeastasia'

param publicIPAddresses_ms365entvm1_ip_name string = 'ms365entvm1-ip'

resource publicIPAddresses_ms365entvm1_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIPAddresses_ms365entvm1_ip_name
  location: location
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
