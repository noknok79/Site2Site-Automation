@description('Specifies the location for resources.')
param location string = 'southeastasia'

param bastionHosts_ms365entvnet1_Bastion_name string = 'ms365entvnet1-Bastion'
param publicIPAddresses_ms365entvnet1_bastion_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-network-rg/providers/Microsoft.Network/publicIPAddresses/ms365entvnet1-bastion'
//param virtualNetworks_ms365entvnet1_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-network-rg/providers/Microsoft.Network/virtualNetworks/ms365entvnet1'

resource bastionHosts_ms365entvnet1_Bastion_name_resource 'Microsoft.Network/bastionHosts@2023-06-01' = {
  name: bastionHosts_ms365entvnet1_Bastion_name
  location: location
  tags: {
    vnet: 'ms365ent'
  }
  sku: {
    name: 'Basic'
  }
  properties: {
    dnsName: 'bst-2b760c11-89e2-4667-95f9-dc5a1b729127.bastion.azure.com'
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        //id: '${bastionHosts_ms365entvnet1_Bastion_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ms365entvnet1_bastion_externalid
          }
          subnet: {
            //id: '${virtualNetworks_ms365entvnet1_externalid}/subnets/AzureBastionSubnet'
          }
        }
      }
    ]
  }
}
