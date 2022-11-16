with Interfaces.C;

with Anet.Sockets.Inet;
with Anet.Sockets.Thin.Netdev.Requests;
with Anet.Errno;

package body Anet.Sockets.Net_Ifaces.Vlan is

   use Anet.Sockets.Thin.Netdev.Requests;
   package C renames Interfaces.C;

   function Get_Vlan_Real_Name
     (Name : Types.Iface_Name_Type)
      return Types.Iface_Name_Type
   is
      C_Name   : constant C.char_array := C.To_C (String (Name));
      Vlan_Req : aliased Vlan_Ioctl_Args;
      Sock     : Sockets.Inet.UDPv4_Socket_Type;
   begin
      Sock.Init;
      Vlan_Req.Cmd := OS_Constants.GET_VLAN_REALDEV_NAME_CMD;
      Vlan_Req.Device1 (1 .. C_Name'Length) := C_Name;

      begin
         Errno.Check_Or_Raise
           (Result  => C_Ioctl_Vlan
              (S   => Socket_Type (Sock).Sock_FD,
               Req => SIOCGIFVLAN,
               Arg => Vlan_Req'Access),
            Message => "Ioctl (" & SIOCGIFVLAN'Img &
              ") failed on interface '" & String (Name) & "'");
      exception
         when Socket_Error =>
            Sock.Close;
            raise;
      end;
      Sock.Close;
      return Types.Iface_Name_Type (C.To_Ada (Vlan_Req.Device2));
   end Get_Vlan_Real_Name;

end Anet.Sockets.Net_Ifaces.Vlan;
