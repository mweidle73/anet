package Anet.Sockets.Net_Ifaces.Vlan is

   function Get_Vlan_Real_Name
     (Name : Types.Iface_Name_Type)
      return Types.Iface_Name_Type;
   --  Get the physical device name of a vlan device.

end Anet.Sockets.Net_Ifaces.Vlan;
