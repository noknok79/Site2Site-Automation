@description('Specifies the location for resources.')
param location string = 'eastus'

param publicIPAddresses_publicip2_name string = 'publicip2'

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
