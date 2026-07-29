targetScope = 'resourceGroup'

var location = 'westus'
var sku = 'Premium_LRS'
var diskSizeGb = 1024
var diskEncryptionSetType = 'EncryptionAtRestWithPlatformKey'
var createOption = 'Empty'
var dataAccessAuthMode = 'None'
var networkAccessPolicy = 'AllowAll'
var publicNetworkAccess = 'Enabled'

resource disks 'Microsoft.Compute/disks@2025-01-02' = [for i in range(1, 6): {
  name: 'az102-clase-03-disk-${i}'
  location: location
  sku: {
    name: sku
  }
  properties: {
    creationData: {
      createOption: createOption
    }
    diskSizeGB: diskSizeGb
    encryption: {
      type: diskEncryptionSetType
    }
    dataAccessAuthMode: dataAccessAuthMode
    networkAccessPolicy: networkAccessPolicy
    publicNetworkAccess: publicNetworkAccess
  }
  tags: {}
}]