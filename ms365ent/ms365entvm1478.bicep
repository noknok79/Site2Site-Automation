@description('Specifies the location for resources.')
param location string = 'southeastasia'

param networkInterfaces_ms365entvm1478_name string = 'ms365entvm1478'
param publicIPAddresses_ms365entvm1_ip_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-network-rg/providers/Microsoft.Network/publicIPAddresses/ms365entvm1-ip'
//param virtualNetworks_ms365entvnet1_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-network-rg/providers/Microsoft.Network/virtualNetworks/ms365entvnet1'
param networkSecurityGroups_ms365entvm1_nsg_externalid string = '/subscriptions/6cfaa4da-a4b7-4bbe-91ba-2c23438b894c/resourceGroups/test-network-rg/providers/Microsoft.Network/networkSecurityGroups/ms365entvm1-nsg'

resource networkInterfaces_ms365entvm1478_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_ms365entvm1478_name
  location: location
  tags: {
    vm1: 'ms365ent'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        //id: '${networkInterfaces_ms365entvm1478_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"c5124f57-bdab-448f-9d1d-4f277d434900"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ms365entvm1_ip_externalid
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            //id: '${virtualNetworks_ms365entvnet1_externalid}/subnets/subnet1-ms365ent'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_ms365entvm1_nsg_externalid
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
