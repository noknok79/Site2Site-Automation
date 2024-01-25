@description('Specifies the location for resources.')
param location string = 'eastus'

param publicIPAddresses_contosovm1_ip_name string = 'contosovm1-ip'

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
