//
//  HCI.swift
//  BlueZ
//
//  Created by Alsey Coleman Miller on 3/1/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

/// Bluetooth HCI
public struct HCI {
    
    // MARK: - Constants
    
    public static let MaximumDeviceCount    = 16
    
    public static let MaximumACLSize        = (1492 + 4)
    
    public static let MaximumSCOSize        = 255
    
    public static let MaximumEventSize      = 260
    
    public static let MaximumFrameSize      = MaximumACLSize + 4
    
    public static let TypeLength            = 1
    
    // MARK: - Typealiases
    
    public typealias Error                  = HCIError
    
    public typealias Event                  = HCIEvent
    
    public typealias DeviceFlag             = HCIDeviceFlag
    
    public typealias DeviceEvent            = HCIDeviceEvent
    
    public typealias ControllerType         = HCIControllerType
    
    public typealias BusType                = HCIBusType
    
    public typealias IOCTL                  = HCIIOCTL
}

/// HCI Errors
public enum HCIError: UInt8, ErrorType {
    
    case UnknownCommand                     = 0x01
    case NoConnection
    case HardwareFailure
    case PageTimeout
    case AuthenticationFailure
    case KeyMissing
    case MemoryFull
    case ConnectionTimeout
    case MaxConnections
    case MaxSCOConnections
    case ACLConnectionExists
    case CommandDisallowed
    case RejectedLimitedResources
    case RejectedSecurity
    case RejectedPersonal
    case HostTimeout
    case UnsupportedFeature
    case InvalidParameters
    case OEUserEndedConnection
    case OELowResources
    case OEPowerOff
    case ConnectionTerminated
    case RepeatedAttempts
    case PairingNotAllowed
    
    // ... Add More
    
    case TransactionCollision               = 0x2a
    case QOSUnacceptableParameter           = 0x2c
    
    // TODO: Add all errors
    
    case HostBusyPairing                    = 0x38
}

/// HCI device flags
public enum HCIDeviceFlag: CInt {
    
    case Up
    case Initialized
    case Running
    
    case PassiveScan
    case InteractiveScan
    case Authenticated
    case Encrypt
    case Inquiry
    
    case Raw
}

/// HCI controller types
public enum HCIControllerType: UInt8 {
    
    case BREDR                              = 0x00
    case AMP                                = 0x01
}

/// HCI bus types
public enum HCIBusType: CInt {
    
    case Virtual
    case USB
    case PCCard
    case UART
    case RS232
    case PCI
    case SDIO
}

/// HCI dev events
public enum HCIDeviceEvent: CInt {
    
    case Register                           = 1
    case Unregister
    case Up
    case Down
    case Suspend
    case Resume
}

/// HCI Packet types
public enum HCIPacketType: UInt8 {
    
    case Command                            = 0x01
    case ACL                                = 0x02
    case SCO                                = 0x03
    case Event                              = 0x04
    case Vendor                             = 0xff
}

/// HCI `ioctl()` defines
public struct HCIIOCTL {
    
    /// #define HCIDEVUP	_IOW('H', 201, int)
    public static let DeviceUp              = IOC.IOW(CInt("H")!, 201, CInt.self)
    
    /// #define HCIDEVDOWN	_IOW('H', 202, int)
    public static let DeviceDown            = IOC.IOW(CInt("H")!, 202, CInt.self)
    
    /// #define HCIDEVRESET	_IOW('H', 203, int)
    public static let DeviceReset           = IOC.IOW(CInt("H")!, 203, CInt.self)
    
    /// #define HCIDEVRESTAT	_IOW('H', 204, int)
    public static let DeviceRestat          = IOC.IOW(CInt("H")!, 204, CInt.self)
    
    
    /// #define HCIGETDEVLIST	_IOR('H', 210, int)
    public static let GetDeviceList         = IOC.IOR(CInt("H")!, 210, CInt.self)
    
    // TODO: All HCI ioctl defines
}

// MARK: - Internal Supporting Types

/// `hci_dev_req`
internal struct HCIDeviceRequest {
    
    /// uint16_t dev_id;
    var identifier: UInt16 = 0
    
    /// uint32_t dev_opt;
    var options: UInt32 = 0
    
    init() { }
}

/// `hci_dev_list_req`
internal struct HCIDeviceListRequest {
    
    /// uint16_t dev_num;
    var count: UInt16 = 0
    
    /// struct hci_dev_req dev_req[0];	/* hci_dev_req structures */
    var dev_req: ()
    
    init() { }
}

/// `hci_inquiry_req`
internal struct HCIInquiryRequest {
    
    /// uint16_t dev_id;
    var identifier: UInt16 = 0
    
    /// uint16_t flags;
    var flags: UInt16 = 0
    
    /// uint8_t  lap[3];
    var lap: (UInt8, UInt8, UInt8) = (0,0,0)
    
    /// uint8_t  length;
    var length: UInt8 = 0
    
    /// uint8_t  num_rsp;
    var responseCount: UInt8 = 0
    
    init() { }
}

/* --------  HCI Packet structures  -------- */

/// hci_command_hdr (packed)
internal struct HCICommandHDR {
    
    static let length = 3
    
    /// OCF & OGF
    var opcode: UInt16 // uint16_t opcode;
    
    var parameterLength: UInt8 // uint8_t plen;
}



