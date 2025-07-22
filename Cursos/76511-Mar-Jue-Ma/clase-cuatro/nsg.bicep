param name string = 'nsg-Main'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name : name
  location: 'westus'
}
