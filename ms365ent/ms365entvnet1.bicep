@description('Specifies the location for resources.')
param location string = 'southeastasia'

param virtualNetworks_ms365entvnet1_name string = 'ms365entvnet1'

resource virtualNetworks_ms365entvnet1_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_ms365entvnet1_name
  location: location
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
        //id: virtualNetworks_ms365entvnet1_name_subnet1_ms365ent.id
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
        //id: virtualNetworks_ms365entvnet1_name_AzureBastionSubnet.id
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
        //id: virtualNetworks_ms365entvnet1_name_GatewaySubnet.id
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

resource virtualNetworks_ms365entvnet1_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_ms365entvnet1_name_resource
  name: 'AzureBastionSubnet'
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
  parent: virtualNetworks_ms365entvnet1_name_resource
  name: 'GatewaySubnet'
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
  parent: virtualNetworks_ms365entvnet1_name_resource
  name: 'subnet1-ms365ent'
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
