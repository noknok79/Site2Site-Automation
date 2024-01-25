@description('Specifies the location for resources.')
param location string = 'eastus'

param networkInterfaces_contosovm1402_name string = 'contosovm1402'
param publicIPAddresses_contosovm1_ip_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/publicIPAddresses/contosovm1-ip'
//param virtualNetworks_contosovnet1_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/virtualNetworks/contosovnet1'
param networkSecurityGroups_contosovm1_nsg_externalid string = '/subscriptions/86a65eef-61ab-42da-b371-c0a66b781013/resourceGroups/test-bicep-rg/providers/Microsoft.Network/networkSecurityGroups/contosovm1-nsg'

resource networkInterfaces_contosovm1402_name_resource 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: networkInterfaces_contosovm1402_name
  location: location
  tags: {
    contosovm1: 'contoso'
  }
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        //id: '${networkInterfaces_contosovm1402_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"d09ee52a-d5c6-43ee-92a6-26802398cb9d"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_contosovm1_ip_externalid
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            //id: '${virtualNetworks_contosovnet1_externalid}/subnets/subnet1-contoso'
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
      id: networkSecurityGroups_contosovm1_nsg_externalid
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
