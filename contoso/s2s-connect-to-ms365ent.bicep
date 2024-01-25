@description('Specifies the location for resources.')
param location string = 'eastus'

param connections_s2s_connect_to_ms365ent_name string = 's2s-connect-to-ms365ent'
param virtualNetworkGateways_contosovirtnetgw_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/virtualNetworkGateways/contosovirtnetgw'
param localNetworkGateways_contosolocgw_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/localNetworkGateways/contosolocgw'

resource connections_s2s_connect_to_ms365ent_name_resource 'Microsoft.Network/connections@2023-06-01' = {
  name: connections_s2s_connect_to_ms365ent_name
  location: location
  tags: {
    connection: 'contoso'
  }
  properties: {
    virtualNetworkGateway1: {
      id: virtualNetworkGateways_contosovirtnetgw_externalid
      properties: {}
    }
    localNetworkGateway2: {
      id: localNetworkGateways_contosolocgw_externalid
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
