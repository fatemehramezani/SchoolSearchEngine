<%@ Page Title="مدیریت مدارس" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="School.aspx.cs" Inherits="Role.Manager.School" %>
<%@ Register Src="~/UserControl/Common/Location.ascx" TagName="Locations" TagPrefix="UserControl" %>
<%@ Register Src="~/UserControl/Common/BasicCommon.ascx" TagName="Commons" TagPrefix="UserControl" %>

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
    <script type="text/javascript">
        function changeRange(sender)
        {
            $(sender).prev().html($(sender).val());
        }
    </script>
    <script lang="jv" type="text/javascript">
        function ValidateLocation(sender)
        {
            var provience = parseInt($('#proviencedropdown').val());
            if (provience == null || provience == -1 || isNaN(provience)) {
                alert('لطفا استان را انتخاب نمایید')
                return false;
            }

            var city = parseInt($('#citydropdown').val());
            if (city == null || city == -1 || isNaN(city))
            {
                alert('لطفا شهر را انتخاب نمایید')
                return false;
            }

            var region = parseInt($('#regiondropdown').val());
            if (region == null || region == -1 || isNaN(region))
            {
                alert('لطفا منطقه/ناحیه را انتخاب نمایید')
                return false;
            }
            document.getElementById('<%=SchoolFormView.FindControl("ProvienceHiddenField").ClientID%>').value = provience;
            document.getElementById('<%=SchoolFormView.FindControl("CityHiddenField").ClientID%>').value = city;
            document.getElementById('<%=SchoolFormView.FindControl("RegionHiddenField").ClientID%>').value = region;
            return true;
        }
    </script>
    <script lang="jv" type="text/javascript">
        function ValidateCommon(sender)
        {
            alert('ValidateCommon');
            var x =  $('#commons3').find('option').filter(function () 
            {
                return ($.trim($(this).text()) === g); 
            }).attr('data-id');
            alert(x);
            alert($('#commons2').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));
            alert($('#commons3').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));

            var gender = parseInt($('#commons2').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));
            if (gender == null || gender == -1 || isNaN(gender))
            {
                alert('لطفا جنسیت را انتخاب نمایید')
                return false;
            }

            var section = parseInt($('#commons3').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));
            if (section == null || section == -1 || isNaN(section))
            {
                alert('لطفا مقطع آموزشی را انتخاب نمایید')
                return false;
            }

            var type = parseInt($('#commons1').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));
            if (type == null || type == -1 || isNaN(type))
            {
                alert('لطفا نوع مدرسه را انتخاب نمایید')
                return false;
            }
            document.getElementById('<%=SchoolFormView.FindControl("GenderHiddenField").ClientID%>').value = gender;
            document.getElementById('<%=SchoolFormView.FindControl("SectionHiddenField").ClientID%>').value = section;
            document.getElementById('<%=SchoolFormView.FindControl("TypeHiddenField").ClientID%>').value = type;
            return true;
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
                    <asp:BoundField DataField="Id" SortExpression="Id"  HeaderText="شماره مدرسه"/>
                    <asp:BoundField DataField="Name" HeaderText="نام مدرسه">
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"/>
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="https://www.madreseyab.com/<%# Eval("Id") %>">مشاهده سایت</a>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="SchoolFormView" runat="server" Width="90%" DataSourceID="SchoolEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="SchoolFormView_ItemDeleted"
                OnItemCommand="SchoolFormView_ItemCommand">
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label ID="NameLabel" runat="server" Text="نام:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="128" />
                        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                     <div class="row">
                        <asp:Label ID="CodeLabel" runat="server" Text="کد:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="CodeTextBox" runat="server" Text='<%# Bind("Code") %>' MaxLength="32" />                        
                    </div>
                     <div class="row">
                        <asp:Label ID="FounderLabel" runat="server" Text="موسس:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="FounderTextBox" runat="server" Text='<%# Bind("Founder") %>' MaxLength="64" />                        
                    </div>
                     <div class="row">
                        <asp:Label ID="ManagerLabel" runat="server" Text="مدیر:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="ManagerTextBox" runat="server" Text='<%# Bind("Manager") %>' MaxLength="64" />
                        <asp:RequiredFieldValidator ID="ManagerRequiredFieldValidator" runat="server" ControlToValidate="ManagerTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="MinTuitionLabel" runat="server" Text="حداقل شهریه(میلیون):"></asp:Label>
                        <span id="minSpan"><%# Eval("MinTuition") %></span>
                        <asp:TextBox ID="MinTuitionTextBox" onChange="changeRange(this);" runat="server" type="range" max="50" min="0" Text='<%# Bind("MinTuition") %>' Width="40%"></asp:TextBox>
                    </div>
                    <div class="row">
                        <asp:Label ID="MaxLabel3" runat="server" Text="حداکثر(میلیون تومان):"></asp:Label>
                        <span id="maxSpan"><%# Eval("MaxTuition") %></span>
                        <asp:TextBox ID="MaxTuitionTextBox" onChange="changeRange(this);" runat="server" type="range" max="50" min="0" Text='<%# Bind("MaxTuition") %>' Width="40%"></asp:TextBox>
                    </div>
                     <div class="row">
                        <asp:Label ID="Phone1Label" runat="server" Text="تلفن 1:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="Phone1TextBox" runat="server" Text='<%# Bind("Phone1") %>' MaxLength="11" />
                        <asp:RequiredFieldValidator ID="Phone1RequiredFieldValidator" runat="server" ControlToValidate="Phone1TextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="Phone2Label" runat="server" Text="تلفن 2:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="Phone2TextBox" runat="server" Text='<%# Bind("Phone2") %>' MaxLength="11" />                        
                    </div>
                    <div class="row">
                        <asp:Label ID="WebsiteLabel" runat="server" Text="وب سایت:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' MaxLength="128" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="استان/شهر/منطقه:"></asp:Label>
                    </div>
                    <div class="row" id="locationscontainer" style="width:90%">
                        <UserControl:Locations runat="server" />
                        <asp:HiddenField ID="ProvienceHiddenField" runat="server" Value='<%#Bind("ProvienceId") %>'/>
                        <asp:HiddenField ID="CityHiddenField" runat="server" Value='<%#Bind("CityId") %>'/>
                        <asp:HiddenField ID="RegionHiddenField" runat="server" Value='<%#Bind("RegionId") %>'/>
                    </div>
                    <div class="row">
                        <asp:Label ID="Label2" runat="server" Text="جنسیت/مقطع آموزشی/نوع مدرسه:"></asp:Label>
                    </div>
                    <div class="row" id="commonscontainer" style="width:90%">
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="2" ID="Genders"/>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="3" ID="Sections"/>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="1" ID="Types"/>
                        </div>
                        <asp:HiddenField ID="GenderHiddenField" runat="server" Value='<%#Bind("GenderId") %>'/>
                        <asp:HiddenField ID="SectionHiddenField" runat="server" Value='<%#Bind("SectionId") %>'/>
                        <asp:HiddenField ID="TypeHiddenField" runat="server" Value='<%#Bind("TypeId") %>'/>
                    </div>
                    <div class="row">
                        <asp:Label ID="AddressLabel" runat="server" Text="آدرس:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' MaxLength="512" />
                    </div>
                    <div class="row">
                        <asp:Label ID="TelegramLabel" runat="server" Text="کانال تلگرام:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TelegramTextBox" runat="server" Text='<%# Bind("Telegram") %>' MaxLength="512" />
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
                         <asp:CKEditor ID="DescriptionTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Description")%>'/>                        
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                                ValidationGroup="Update" OnClientClick="if (ValidateLocation()) {if(ValidateCommon()){if(!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return true;else return false;}else return false;}else return false;" />
                            <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" />
                        </div>
                    </div>                        
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="NameLabel" runat="server" Text="نام:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="128" />
                        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </div>
                     <div class="row">
                        <asp:Label ID="CodeLabel" runat="server" Text="کد:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="CodeTextBox" runat="server" Text='<%# Bind("Code") %>' MaxLength="32" />                        
                    </div>
                     <div class="row">
                        <asp:Label ID="FounderLabel" runat="server" Text="موسس:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="FounderTextBox" runat="server" Text='<%# Bind("Founder") %>' MaxLength="64" />                        
                    </div>
                     <div class="row">
                        <asp:Label ID="ManagerLabel" runat="server" Text="مدیر:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="ManagerTextBox" runat="server" Text='<%# Bind("Manager") %>' MaxLength="64" />
                        <asp:RequiredFieldValidator ID="ManagerRequiredFieldValidator" runat="server" ControlToValidate="ManagerTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="MinTuitionLabel" runat="server" Text="حداقل شهریه(میلیون):"></asp:Label>
                        <span id="minSpan"></span>
                        <asp:TextBox ID="MinTuitionTextBox" onChange="changeRange(this);" runat="server" type="range" max="50" min="0" Text='<%# Bind("MinTuition") %>' Width="40%"></asp:TextBox>
                    </div>
                    <div class="row">
                        <asp:Label ID="MaxLabel3" runat="server" Text="حداکثر(میلیون تومان):"></asp:Label>
                        <span id="maxSpan"></span>
                        <asp:TextBox ID="MaxTuitionTextBox" onChange="changeRange(this);" runat="server" type="range" max="50" min="0" Text='<%# Bind("MaxTuition") %>' Width="40%"></asp:TextBox>
                    </div>
                     <div class="row">
                        <asp:Label ID="Phone1Label" runat="server" Text="تلفن 1:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="Phone1TextBox" runat="server" Text='<%# Bind("Phone1") %>' MaxLength="11" />
                        <asp:RequiredFieldValidator ID="Phone1RequiredFieldValidator" runat="server" ControlToValidate="Phone1TextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="Phone2Label" runat="server" Text="تلفن 2:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="Phone2TextBox" runat="server" Text='<%# Bind("Phone2") %>' MaxLength="11" />                        
                    </div>
                    <div class="row">
                        <asp:Label ID="WebsiteLabel" runat="server" Text="وب سایت:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="WebsiteTextBox" runat="server" Text='<%# Bind("Website") %>' MaxLength="128" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="استان/شهر/منطقه:"></asp:Label>
                        </div>
                    <div class="row" id="locationscontainer" style="width:90%">
                        <UserControl:Locations runat="server" />
                        <asp:HiddenField ID="ProvienceHiddenField" runat="server" Value='<%#Bind("ProvienceId") %>'/>
                        <asp:HiddenField ID="CityHiddenField" runat="server" Value='<%#Bind("CityId") %>'/>
                        <asp:HiddenField ID="RegionHiddenField" runat="server" Value='<%#Bind("RegionId") %>'/>
                    </div>
                    <div class="row">
                        <asp:Label ID="Label2" runat="server" Text="جنسیت/مقطع آموزشی/نوع مدرسه:"></asp:Label>
                    </div>
                    <div class="row" id="commonscontainer" style="width:90%">
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="2" ID="Genders"/>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="3" ID="Sections"/>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-12">
                            <UserControl:Commons runat="server" parentId="1" ID="Types"/>
                        </div>
                        <asp:HiddenField ID="GenderHiddenField" runat="server" Value='<%#Bind("GenderId") %>'/>
                        <asp:HiddenField ID="SectionHiddenField" runat="server" Value='<%#Bind("SectionId") %>'/>
                        <asp:HiddenField ID="TypeHiddenField" runat="server" Value='<%#Bind("TypeId") %>'/>
                    </div>
                    <div class="row">
                        <asp:Label ID="AddressLabel" runat="server" Text="آدرس:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' MaxLength="512" />
                    </div>
                    <div class="row">
                        <asp:Label ID="TelegramLabel" runat="server" Text="کانال تلگرام:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TelegramTextBox" runat="server" Text='<%# Bind("Telegram") %>' MaxLength="512" />
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
                         <asp:CKEditor ID="DescriptionTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Description")%>'/>                        
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد" OnClientClick="if (ValidateLocation()) {if(ValidateCommon()){if(!confirm('آيا از درج مدرسه مطمئن هستيد؟')) return true;else return false;}else return false;}else return false;"
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


