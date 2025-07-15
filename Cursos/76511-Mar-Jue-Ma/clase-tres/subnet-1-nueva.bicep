
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: 'vnet-10.0.0.0'
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  name: 'vnet-10.0.0.0-subnet-1'
  parent: vnet
  properties: {
    addressPrefix: '10.0.1.0/24'
  }
}
