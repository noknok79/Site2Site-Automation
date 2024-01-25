@description('Specifies the location for resources.')
param location string = 'eastus'

param localNetworkGateways_contosolocgw_name string = 'contosolocgw'

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
