@secure()
param adminPassword string
param adminUsername string = 'AzureUser'
param virtualMachines_vm4trainner_01_name string = 'vm4trainner-02'
param networkInterfaces_vm4trainner_01136_name string = 'nic-vm4trainner-02'
param publicIPAddresses_vm4trainner_01_ip_name string = 'vm4trainner-02-ip'
param virtualNetworks_vnet_10_0_0_0_externalid string = '/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe/resourceGroups/Rg-Az104-Clase-Tres/providers/Microsoft.Network/virtualNetworks/vnet-10.0.0.0'
param applicationSecurityGroups_Asg_WebServers_externalid string = '/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe/resourceGroups/Rg-Az104-Clase-Tres/providers/Microsoft.Network/applicationSecurityGroups/Asg-WebServers'
param networkSecurityGroups_Nsg_General_externalid string = '/subscriptions/91dc3067-fd7a-4ed3-95eb-8c938f69cbfe/resourceGroups/Rg-Az104-Clase-Tres/providers/Microsoft.Network/networkSecurityGroups/Nsg-General'

resource publicIPAddresses_vm4trainner_01_ip_name_resource 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: publicIPAddresses_vm4trainner_01_ip_name
  location: 'westus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource networkInterfaces_vm4trainner_01136_name_resource 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: networkInterfaces_vm4trainner_01136_name
  location: 'westus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm4trainner_01_ip_name_resource.id
            properties: {
              deleteOption: 'Delete'
            }
          }
          subnet: {
            id: '${virtualNetworks_vnet_10_0_0_0_externalid}/subnets/vnet-10.0.0.0-subnet-0'
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationSecurityGroups: [
            {
              id: applicationSecurityGroups_Asg_WebServers_externalid
            }
          ]
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
      id: networkSecurityGroups_Nsg_General_externalid
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}


resource virtualMachines_vm4trainner_01_name_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: virtualMachines_vm4trainner_01_name
  location: 'westus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS2_v2'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'windows-11'
        sku: 'win11-22h2-entn'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm4trainner_01_name}_OsDisk_1_6f185ab4edea43fb8d00be0b585e65bd'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm4trainner_01_name}_OsDisk_1_6f185ab4edea43fb8d00be0b585e65bd'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm4trainner_01_name
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm4trainner_01136_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Client'
  }
}

