<%@ Page Title="مدیریت کاربران" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master"
    AutoEventWireup="true" Inherits="Admin_User" Codebehind="User.aspx.cs" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="Server">
    مدیریت کاربران
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید کاربران را مدیریت کنید یا دسترسی آن ها را غیر فعال کنید.
</asp:Content>
<asp:Content ID="UserContent" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:MultiView runat="server" ID="UserMultiView" ActiveViewIndex="0">
        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
            <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click"
                OnClientClick="return false;" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="NameLabel" runat="server" Text="نام:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="FirstNameTextBox" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="DescriptionLabel" runat="server" Text="نام خانوادگی:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="LastNameTextBox" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="UserNameLabel" runat="server" Text="نام کاربری:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="UserNameTextBox" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="SizePageLabel" runat="server" Text="سایز صفحه:" SkinID="Caption"></asp:Label>
            <asp:DropDownList ID="PageSizeDropDownList" SkinID="SearchDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="5">[پیش فرض]</asp:ListItem>
                <asp:ListItem Value="5">5 رکورد</asp:ListItem>
                <asp:ListItem Value="10">10 رکورد</asp:ListItem>
                <asp:ListItem Value="15">15 رکورد</asp:ListItem>
                <asp:ListItem Value="20">20 رکورد</asp:ListItem>
                <asp:ListItem Value="25">25 رکورد</asp:ListItem>
                <asp:ListItem Value="1000000">تمام رکورد ها</asp:ListItem>
            </asp:DropDownList>
            <br />
            <div style="height: 450px !important; overflow: auto">
                <asp:GridView ID="UserGridView" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="Id"
                    DataSourceID="UserEntityDataSource"
                    OnSelectedIndexChanged="UserGridView_SelectedIndexChanged"
                    Width="90%"
                    AllowSorting="True" AllowPaging="True"
                    HorizontalAlign="Right">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="false"
                            SortExpression="Id" />
                        <asp:BoundField DataField="Username" HeaderText="نام کاربری" SortExpression="Username">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FirstName" HeaderText="نام" SortExpression="FirstName"></asp:BoundField>
                        <asp:BoundField DataField="LastName" HeaderText="نام خانوادگی" SortExpression="LastName" />
                    </Columns>
                </asp:GridView>
            </div>
        </asp:View>
        <asp:View runat="server" ID="EditView">
            <asp:FormView ID="UserFormView" runat="server" DataSourceID="UserEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="UserFormView_ItemDeleted"
                OnItemCommand="UserFormView_ItemCommand" Width="90%">
                <EditItemTemplate>
                    <h2>ویرایش کاربر</h2>
                    <div class="rows">
                        <div class="input_section">
                            <label>نام</label>
                            <asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" ControlToValidate="FirstNameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                        </div>
                        <div class="input_section">
                            <label>نام خانوادگی</label>
                            <asp:TextBox ID="LastNameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server" ControlToValidate="LastNameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                        </div>
                        <div class="input_section" style="margin: 0px !important;">
                            <label>نام کاربری</label>
                            <asp:TextBox ID="UsernameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("Username") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UsernameRequiredFieldValidator" runat="server" ControlToValidate="UsernameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="rows">
                        <div class="input_section" style="margin: 0px !important;">
                            <label>پست الکترونیکی</label>
                            <input type="text" name="textfield" id="text3" />
                        </div>
                        <div class="users_checkbox_container">
                            <asp:CheckBox ID="ActiveCheckBox" Checked='<%# Bind("IsLockedOut") %>' runat="server"
                                Text="قفل" />
                        </div>
                    </div>
                    <div class="rows">
                        <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                            Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" SkinID="MetroUpdateModeButton" />
                        <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                            ValidationGroup="Update" OnClientClick="if (!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return false;" SkinID="MetroUpdateModeButton" />
                        <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" SkinID="MetroUpdateModeButton" />
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>

                    <h2>ایجاد کاربر</h2>
                    <div class="rows">
                        <div class="input_section">
                            <label>نام</label>
                            <asp:TextBox ID="FirstNameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" ControlToValidate="FirstNameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </div>
                        <div class="input_section">
                            <label>نام خانوادگی</label>
                            <asp:TextBox ID="LastNameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server" ControlToValidate="LastNameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </div>
                        <div class="input_section" style="margin: 0px !important;">
                            <label>نام کاربری</label>
                            <asp:TextBox ID="UsernameTextBox" runat="server" MaxLength="50"
                                Text='<%# Bind("Username") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UsernameRequiredFieldValidator" runat="server" ControlToValidate="UsernameTextBox"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="rows">
                        <div class="input_section" style="margin: 0px !important;">
                            <label>پست الکترونیکی</label>
                            <input type="text" name="textfield" id="text3" />
                        </div>
                        <div class="users_checkbox_container">
                            <asp:CheckBox ID="ActiveCheckBox" Checked='<%# Bind("IsLockedOut") %>' runat="server"
                                Text="قفل" />
                        </div>
                    </div>
                    <div class="rows">
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد"
                            ValidationGroup="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="انصراف" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <asp:EntityDataSource ID="UserEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="Users" OnDeleted="UserEntityDataSource_Command"
        OnInserted="UserEntityDataSource_Command" OnUpdated="UserEntityDataSource_Command"
        Where="(@FirstName is null || it.FirstName LIKE '%' + @FirstName + '%') and (@LastName is null || it.LastName LIKE '%' + @LastName + '%') and (@Username is null || it.Username LIKE '%' + @Username + '%')"
        EnableUpdate="True"
        EnableDelete="True"
        EnableInsert="True"
        EnableFlattening="False"
        OrderBy="it.[Username]">
        <WhereParameters>
            <asp:ControlParameter ControlID="FirstNameTextBox" Name="FirstName" Type="String" />
            <asp:ControlParameter ControlID="LastNameTextBox" Name="LastName" Type="String" />
            <asp:ControlParameter ControlID="UsernameTextBox" Name="Username" Type="String" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
