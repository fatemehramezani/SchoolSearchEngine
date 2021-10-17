<%@ Page Title="مدیریت مدارس" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" Inherits="Role.Manager.School" Codebehind="School.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    مدیریت مدارس
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    از طریق این صفحه می توانید  اطلاعات  به نمایش در آمده مربوط به مدارس خود در صفحه اصلی را مدیریت نمایید. 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script lang="jv" type="text/javascript">
        function SelectItem(sender, e) {
            e.IsValid = (e.Value != '0');
        }
    </script>
    <asp:MultiView runat="server" ID="SchoolMultiView" ActiveViewIndex="0">
        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="NewImageButton" runat="server" OnClick="NewImageButton_Click" SkinID="PanelAddImageButton" />
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
            <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="NameLabel" runat="server" Text="نام مدرسه:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="NameTextBox" runat="server" SkinID="TextBox"></asp:TextBox>
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
            <asp:GridView ID="SchoolGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Id" DataSourceID="SchoolEntityDataSource" HorizontalAlign="Center"
                OnSelectedIndexChanged="SchoolGridView_SelectedIndexChanged" PageSize="5" Width="90%" AllowSorting="True" AllowPaging="True">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                        </ItemTemplate>
                        <ItemStyle Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Id" Visible="False" SortExpression="Id" />
                    <asp:BoundField DataField="Name" HeaderText="نام مدرسه">
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="SchoolFormView" runat="server" Width="90%" DataSourceID="SchoolEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="SchoolFormView_ItemDeleted"
                OnItemCommand="SchoolFormView_ItemCommand">
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label ID="NameLabel" runat="server" Text="نام مدرسه:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="128" />
                        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="PictureLabel" runat="server" Text="لوگو:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="PictureFileUpload" runat="server" />
                        <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر لوگو" />
                    </div>
                    <div class="row">
                        <asp:Label ID="BannerLabel" runat="server" Text="بنر:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="BannerFileUpload" runat="server" />
                        <asp:CheckBox ID="BannerCheckBox" runat="server" Text="تغییر بنر" />
                    </div>
                    <div class="row">
                        <asp:Label ID="DescriptionLabel" runat="server" Text="توضیحات:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Width="100%" TextMode="MultiLine" Rows="15" MaxLength="1024"/>
                        <asp:RequiredFieldValidator ID="SchoolRequiredFieldValidator" runat="server" ControlToValidate="DescriptionTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                                ValidationGroup="Update" OnClientClick="if (!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" />
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="NameLabel" runat="server" Text="نام مدرسه:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="500" />
                        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="PictureLabel" runat="server" Text="لوگو:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="PictureFileUpload" runat="server" />
                        <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر تصویر" />
                    </div>
                    <div class="row">
                        <asp:Label ID="BannerLabel" runat="server" Text="بنر:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="BannerFileUpload" runat="server" />
                        <asp:CheckBox ID="BannerCheckBox" runat="server" Text="تغییر بنر" />
                    </div>
                    <div class="row">
                        <asp:Label ID="DescriptionLabel" runat="server" Text="توضیحات:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Width="100%" TextMode="MultiLine" Rows="15" />
                        <asp:RequiredFieldValidator ID="SchoolRequiredFieldValidator" runat="server" ControlToValidate="DescriptionTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                        <br />

                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد"
                                ValidationGroup="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="انصراف" />
                        </div>
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <ef:EntityDataSource ID="SchoolEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="Information"
        EnableUpdate="True"
        EnableDelete="True"
        EnableInsert="True"
        OnDeleted="SchoolEntityDataSource_Command"
        OnInserted="SchoolEntityDataSource_Command"
        OnUpdated="SchoolEntityDataSource_Command"
        OnInserting="SchoolEntityDataSource_Commanding"
        OnUpdating="SchoolEntityDataSource_Commanding"
        OrderBy=" it.[Id] desc" EnableFlattening="False"
        Where="(@Name is null || it.Name LIKE '%' + @Name + '%') && (@ApplicantId is null || it.ApplicantId = @ApplicantId)">
        <WhereParameters>
            <asp:ControlParameter ControlID="NameTextBox" Name="Name" Type="String" />
            <asp:ProfileParameter PropertyName="ApplicantId" Name="ApplicantId" Type="Int32" />
        </WhereParameters>
    </ef:EntityDataSource>

</asp:Content>


