@description('Specifies the location for resources.')
param location string = 'eastus'

param virtualNetworkGateways_contosovirtnetgw_name string = 'contosovirtnetgw'
param publicIPAddresses_publicip2_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/publicIPAddresses/publicip2'
param virtualNetworks_contosovnet1_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/virtualNetworks/contosovnet1'
param publicIPAddresses_publicip3_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/publicIPAddresses/publicip3'

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
        //id: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicip2_externalid
          }
          subnet: {
            id: '${virtualNetworks_contosovnet1_externalid}/subnets/GatewaySubnet'
          }
        }
      }
      {
        name: 'activeActive'
        //id: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/activeActive'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_publicip3_externalid
          }
          subnet: {
            id: '${virtualNetworks_contosovnet1_externalid}/subnets/GatewaySubnet'
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
      /*bgpPeeringAddresses: [
        {
          ipconfigurationId: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/default'
          customBgpIpAddresses: []
        }
        {
          ipconfigurationId: '${virtualNetworkGateways_contosovirtnetgw_name_resource.id}/ipConfigurations/activeActive'
          customBgpIpAddresses: []
        }
      ]*/
    }
    vpnGatewayGeneration: 'Generation1'
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}
