<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="UsersAndRoles.aspx.cs" Inherits="Admin_Roles_UsersAndRoles" Title="مدیریت نقش کاربران" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="Server">
    <script language="jv" type="text/javascript">
        function SelectItem(source, arguments) {
            var Cbox = $find(source.controltovalidate);
            alert(Cbox.get_selectedIndex());
            if (Cbox) {
                if (Cbox.get_selectedIndex() == null || Cbox.get_selectedIndex() == "")
                    arguments.IsValid = false;
                else
                    arguments.IsValid = true;
                if (Cbox.get_selectedIndex() != null && Cbox.get_selectedIndex() >= 0)
                    arguments.IsValid = true;
            }
        }
    </script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
        });
    </script>
    <style>
        .formDropDownList {
            margin-top: 0px !important;
        }
    </style>

    <link href="../../App_Themes/Default/css/Metro.css" rel="stylesheet" type="text/css" />
    <link href="../../App_Themes/Default/css/blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../App_Themes/Default/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="../../App_Themes/Default/js/dropdown.js"></script>
    <script type="text/javascript" src="../../App_Themes/Default/js/modernizr.js"></script>
    <script type="text/javascript" src="../../App_Themes/Default/js/jquery.icheck.min.js"></script>
    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
        });
    </script>


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="TitleContent" runat="Server">
    نقش کاربران
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید نقش کاربران را مشخص کنید.
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="vars_fields_section">
        <div class="rows">
            <div class="input_section">
                <h2>مدیریت کاربران نقش</h2>
                <label>انتخاب نقش</label>
                <asp:CustomValidator ID="RoleListCustomValidator" runat="server" ClientValidationFunction="SelectItem"
                    ControlToValidate="RoleList" Display="Dynamic" ErrorMessage="نقش اجباری است" ValidateEmptyText="true"
                    ValidationGroup="UserToRole">*</asp:CustomValidator>
                <asp:DropDownList ID="RoleList" AutoPostBack="true" runat="server" 
                    DataValueField=""
                    OnSelectedIndexChanged="RoleList_SelectedIndexChanged">                    
                </asp:DropDownList>
            </div>            
            <div style="float: right; margin-top: 60px;">
                <asp:GridView ID="RolesUserList" runat="server" AutoGenerateColumns="False"
                    EmptyDataText="هیچ کاربری با این نقش وجود ندارد"
                    OnRowDeleting="RolesUserList_RowDeleting">
                    <Columns>
                        <asp:TemplateField HeaderText="کاربران">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="UserNameLabel" Text='<%# Container.DataItem %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="DeleteItemButton" runat="server" CommandName="Delete" SkinID="DeleteItemButton" />
                            </ItemTemplate>
                            <ItemStyle Width="25px" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </div>
        </div>
    </div>
    <div class="vars_fields_section">
        <div class="rows">
            <div class="input_section">
                <h2>تخصیص کاربر</h2>
                <label>انتخاب کاربر</label>
                <asp:CustomValidator ID="UserNameToAddToRoleDropDownCustomValidator" runat="server" ClientValidationFunction="SelectItem"
                    ControlToValidate="UserNameToAddToRoleDropDown" Display="Dynamic" ErrorMessage="کاربر اجباری است" ValidateEmptyText="true"
                    ValidationGroup="UserToRole">*</asp:CustomValidator>
                <asp:DropDownList ID="UserNameToAddToRoleDropDown" DataTextField="UserName" DataValueField="UserName" runat="server">                   
                </asp:DropDownList>
            </div>
            <div style="margin-top: 60px">
                <asp:Button ID="AddUserToRoleButton" runat="server" Text="انتخاب"
                    OnClick="AddUserToRoleButton_Click" ValidationGroup="UserToRole" SkinID="MetroInsertModeButton" />
            </div>
        </div>
        <asp:Label ID="ActionStatus" runat="server" ForeColor="Red" Width="100%"></asp:Label>
    </div>
    <div class="vars_fields_section">
        <div class="rows">
            <div class="input_section">
                <h2>مدیریت نقش کاربران</h2>
                <label>انتخاب کاربر</label>
                <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True"
                    DataTextField="UserName" DataValueField="UserName"
                    OnSelectedIndexChanged="UserList_SelectedIndexChanged">
                </asp:DropDownList>
                <br />
            </div>
        </div>
        <div class="users_roles_container">
            <asp:Repeater ID="UsersRoleList" runat="server">
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="RoleCheckBox"
                        AutoPostBack="true" TextAlign="Left" Text='<%# Container.DataItem %>' OnCheckedChanged="RoleCheckBox_CheckChanged" />
                    <br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>


