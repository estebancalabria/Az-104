param name string = 'vnet-10.1'

resource virtualNetworks_vnet_10_0_name_resource 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: name
  location: 'westus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'subnet-0'
        properties: {
          addressPrefixes: [
            '10.1.0.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

