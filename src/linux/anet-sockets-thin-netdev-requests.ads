--
--  Copyright (C) 2011-2014 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2014 Adrian-Ken Rueegsegger <ken@codelabs.ch>
--
--  This program is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2 of the License, or (at your
--  option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
--  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
--  for more details.
--
--  As a special exception, if other files instantiate generics from this
--  unit,  or  you  link  this  unit  with  other  files  to  produce  an
--  executable   this  unit  does  not  by  itself  cause  the  resulting
--  executable to  be  covered by the  GNU General  Public License.  This
--  exception does  not  however  invalidate  any  other reasons why  the
--  executable file might be covered by the GNU Public License.
--

package Anet.Sockets.Thin.Netdev.Requests is

   SIOCGIFADDR   : constant := 16#8915#; --  Get address
   SIOCGIFFLAGS  : constant := 16#8913#; --  Get flags
   SIOCSIFFLAGS  : constant := 16#8914#; --  Set flags
   SIOCGIFHWADDR : constant := 16#8927#; --  Get hardware address
   SIOCGIFINDEX  : constant := 16#8933#; --  Name -> if_index mapping
   SIOCGIFVLAN   : constant := 16#8982#; --  802.1 VLAN support
   SIOCGIFMTU    : constant := 16#8921#; --  Get MTU

   Get_Requests : constant array (Netdev_Request_Name) of Interfaces.C.int
     := (If_Addr   => SIOCGIFADDR,
         If_Flags  => SIOCGIFFLAGS,
         If_Hwaddr => SIOCGIFHWADDR,
         If_Index  => SIOCGIFINDEX,
         If_Mtu    => SIOCGIFMTU);
   --  Currently supported netdevice ioctl get requests.

   Set_Requests : constant array (Netdev_Request_Name) of Interfaces.C.int
     := (If_Flags => SIOCSIFFLAGS,
         others   => Interfaces.C.int (-1));
   --  Currently supported netdevice ioctl set requests.

   type Vlan_Ioctl_Args is record
      Cmd      : Interfaces.C.int;
      Device1  : Interfaces.C.char_array
        (1 .. Constants.VLANNAMSIZ) := (others => Interfaces.C.nul);
      Device2  : Interfaces.C.char_array
        (1 .. Constants.VLANNAMSIZ) := (others => Interfaces.C.nul);
      Vlan_QOS : Interfaces.C.short := 0;
   end record;
   pragma Convention (C, Vlan_Ioctl_Args);
   --  Vlan ioctl request structure (incomplete struct vlan_ioctl_args).

   function C_Ioctl
     (S   : Interfaces.C.int;
      Req : Interfaces.C.int;
      Arg : access If_Req_Type)
      return Interfaces.C.int;
   pragma Import (C, C_Ioctl, "ioctl");

   function C_Ioctl_Vlan
     (S   : Interfaces.C.int;
      Req : Interfaces.C.int;
      Arg : access Vlan_Ioctl_Args)
      return Interfaces.C.int;
   pragma Import (C, C_Ioctl_Vlan, "ioctl");

end Anet.Sockets.Thin.Netdev.Requests;
