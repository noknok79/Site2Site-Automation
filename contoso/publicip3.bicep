@description('Specifies the location for resources.')
param location string = 'eastus'

param publicIPAddresses_publicip3_name string = 'publicip3'

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
