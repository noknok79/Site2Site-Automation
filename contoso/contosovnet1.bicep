@description('Specifies the location for resources.')
param location string = 'eastus'

param virtualNetworks_contosovnet1_name string = 'contosovnet1'

resource virtualNetworks_contosovnet1_name_resource 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworks_contosovnet1_name
  location: location
  tags: {
    vnet: 'contoso'
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
        name: 'subnet1-contoso'
        //id: virtualNetworks_contosovnet1_name_subnet1_contoso.id
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
        //id: virtualNetworks_contosovnet1_name_AzureBastionSubnet.id
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
        //id: virtualNetworks_contosovnet1_name_GatewaySubnet.id
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

resource virtualNetworks_contosovnet1_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefix: '10.0.1.0/26'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_contosovnet1_name_resource
  ]
}

resource virtualNetworks_contosovnet1_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
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
    virtualNetworks_contosovnet1_name_resource
  ]
}

resource virtualNetworks_contosovnet1_name_subnet1_contoso 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' = {
  parent: virtualNetworks_contosovnet1_name_resource
  name: 'subnet1-contoso'
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
    virtualNetworks_contosovnet1_name_resource
  ]
}
