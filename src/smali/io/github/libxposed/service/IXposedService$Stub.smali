.class public abstract Lio/github/libxposed/service/IXposedService$Stub;
.super Landroid/os/Binder;
.source "IXposedService.java"

# interfaces
.implements Lio/github/libxposed/service/IXposedService;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Stub"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/github/libxposed/service/IXposedService$Stub$Proxy;
    }
.end annotation


# static fields
.field static final TRANSACTION_deleteRemoteFile:I = 0x21

.field static final TRANSACTION_deleteRemotePreferences:I = 0x17

.field static final TRANSACTION_getApiVersion:I = 0x2

.field static final TRANSACTION_getFrameworkName:I = 0x3

.field static final TRANSACTION_getFrameworkProperties:I = 0x6

.field static final TRANSACTION_getFrameworkVersion:I = 0x4

.field static final TRANSACTION_getFrameworkVersionCode:I = 0x5

.field static final TRANSACTION_getRunningTargets:I = 0xe

.field static final TRANSACTION_getScope:I = 0xb

.field static final TRANSACTION_hotReloadModule:I = 0xf

.field static final TRANSACTION_listRemoteFiles:I = 0x1f

.field static final TRANSACTION_openRemoteFile:I = 0x20

.field static final TRANSACTION_removeScope:I = 0xd

.field static final TRANSACTION_requestRemotePreferences:I = 0x15

.field static final TRANSACTION_requestScope:I = 0xc

.field static final TRANSACTION_updateRemotePreferences:I = 0x16


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 101
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    .line 102
    const-string v0, "io.github.libxposed.service.IXposedService"

    invoke-virtual {p0, p0, v0}, Lio/github/libxposed/service/IXposedService$Stub;->attachInterface(Landroid/os/IInterface;Ljava/lang/String;)V

    return-void
.end method

.method public static asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IXposedService;
    .registers 3

    if-nez p0, :cond_4

    const/4 p0, 0x0

    return-object p0

    .line 113
    :cond_4
    const-string v0, "io.github.libxposed.service.IXposedService"

    invoke-interface {p0, v0}, Landroid/os/IBinder;->queryLocalInterface(Ljava/lang/String;)Landroid/os/IInterface;

    move-result-object v0

    if-eqz v0, :cond_13

    .line 114
    instance-of v1, v0, Lio/github/libxposed/service/IXposedService;

    if-eqz v1, :cond_13

    .line 115
    check-cast v0, Lio/github/libxposed/service/IXposedService;

    return-object v0

    .line 117
    :cond_13
    new-instance v0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;

    invoke-direct {v0, p0}, Lio/github/libxposed/service/IXposedService$Stub$Proxy;-><init>(Landroid/os/IBinder;)V

    return-object v0
.end method


# virtual methods
.method public asBinder()Landroid/os/IBinder;
    .registers 1

    return-object p0
.end method

.method public onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .registers 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const/4 v0, 0x1

    if-lt p1, v0, :cond_d

    const v1, 0xffffff

    if-gt p1, v1, :cond_d

    .line 126
    const-string v1, "io.github.libxposed.service.IXposedService"

    invoke-virtual {p2, v1}, Landroid/os/Parcel;->enforceInterface(Ljava/lang/String;)V

    :cond_d
    const/4 v1, 0x2

    if-eq p1, v1, :cond_fe

    const/4 v1, 0x3

    if-eq p1, v1, :cond_f3

    const/4 v1, 0x4

    if-eq p1, v1, :cond_e8

    const/4 v1, 0x5

    if-eq p1, v1, :cond_dd

    const/4 v1, 0x6

    if-eq p1, v1, :cond_d2

    packed-switch p1, :pswitch_data_10a

    packed-switch p1, :pswitch_data_118

    packed-switch p1, :pswitch_data_122

    .line 262
    invoke-super {p0, p1, p2, p3, p4}, Landroid/os/Binder;->onTransact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    move-result p0

    return p0

    .line 254
    :pswitch_2a
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 255
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedService$Stub;->deleteRemoteFile(Ljava/lang/String;)Z

    move-result p0

    .line 256
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 257
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeInt(I)V

    goto/16 :goto_108

    .line 245
    :pswitch_3a
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 246
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedService$Stub;->openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object p0

    .line 247
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 248
    invoke-static {p3, p0, v0}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smwriteTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V

    goto/16 :goto_108

    .line 237
    :pswitch_4a
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->listRemoteFiles()[Ljava/lang/String;

    move-result-object p0

    .line 238
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 239
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeStringArray([Ljava/lang/String;)V

    goto/16 :goto_108

    .line 230
    :pswitch_56
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 231
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedService$Stub;->deleteRemotePreferences(Ljava/lang/String;)V

    .line 232
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_108

    .line 220
    :pswitch_62
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 222
    sget-object p4, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p4}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smreadTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/os/Bundle;

    .line 223
    invoke-virtual {p0, p1, p2}, Lio/github/libxposed/service/IXposedService$Stub;->updateRemotePreferences(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 224
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto/16 :goto_108

    .line 211
    :pswitch_76
    invoke-virtual {p2}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    .line 212
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedService$Stub;->requestRemotePreferences(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p0

    .line 213
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 214
    invoke-static {p3, p0, v0}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smwriteTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V

    goto/16 :goto_108

    .line 199
    :pswitch_86
    invoke-virtual {p2}, Landroid/os/Parcel;->readLong()J

    move-result-wide v1

    .line 201
    sget-object p1, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;

    invoke-static {p2, p1}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smreadTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/Bundle;

    .line 203
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    invoke-static {p2}, Lio/github/libxposed/service/IHotReloadCallback$Stub;->asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IHotReloadCallback;

    move-result-object p2

    .line 204
    invoke-virtual {p0, v1, v2, p1, p2}, Lio/github/libxposed/service/IXposedService$Stub;->hotReloadModule(JLandroid/os/Bundle;Lio/github/libxposed/service/IHotReloadCallback;)V

    .line 205
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_108

    .line 191
    :pswitch_a1
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getRunningTargets()Ljava/util/List;

    move-result-object p0

    .line 192
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 193
    invoke-static {p3, p0, v0}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smwriteTypedList(Landroid/os/Parcel;Ljava/util/List;I)V

    goto :goto_108

    .line 184
    :pswitch_ac
    invoke-virtual {p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object p1

    .line 185
    invoke-virtual {p0, p1}, Lio/github/libxposed/service/IXposedService$Stub;->removeScope(Ljava/util/List;)V

    .line 186
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    goto :goto_108

    .line 175
    :pswitch_b7
    invoke-virtual {p2}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;

    move-result-object p1

    .line 177
    invoke-virtual {p2}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object p2

    invoke-static {p2}, Lio/github/libxposed/service/IXposedScopeCallback$Stub;->asInterface(Landroid/os/IBinder;)Lio/github/libxposed/service/IXposedScopeCallback;

    move-result-object p2

    .line 178
    invoke-virtual {p0, p1, p2}, Lio/github/libxposed/service/IXposedService$Stub;->requestScope(Ljava/util/List;Lio/github/libxposed/service/IXposedScopeCallback;)V

    goto :goto_108

    .line 167
    :pswitch_c7
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getScope()Ljava/util/List;

    move-result-object p0

    .line 168
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 169
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V

    goto :goto_108

    .line 160
    :cond_d2
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getFrameworkProperties()J

    move-result-wide p0

    .line 161
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 162
    invoke-virtual {p3, p0, p1}, Landroid/os/Parcel;->writeLong(J)V

    goto :goto_108

    .line 153
    :cond_dd
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getFrameworkVersionCode()J

    move-result-wide p0

    .line 154
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 155
    invoke-virtual {p3, p0, p1}, Landroid/os/Parcel;->writeLong(J)V

    goto :goto_108

    .line 146
    :cond_e8
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getFrameworkVersion()Ljava/lang/String;

    move-result-object p0

    .line 147
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 148
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_108

    .line 139
    :cond_f3
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getFrameworkName()Ljava/lang/String;

    move-result-object p0

    .line 140
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 141
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_108

    .line 132
    :cond_fe
    invoke-virtual {p0}, Lio/github/libxposed/service/IXposedService$Stub;->getApiVersion()I

    move-result p0

    .line 133
    invoke-virtual {p3}, Landroid/os/Parcel;->writeNoException()V

    .line 134
    invoke-virtual {p3, p0}, Landroid/os/Parcel;->writeInt(I)V

    :goto_108
    return v0

    nop

    :pswitch_data_10a
    .packed-switch 0xb
        :pswitch_c7
        :pswitch_b7
        :pswitch_ac
        :pswitch_a1
        :pswitch_86
    .end packed-switch

    :pswitch_data_118
    .packed-switch 0x15
        :pswitch_76
        :pswitch_62
        :pswitch_56
    .end packed-switch

    :pswitch_data_122
    .packed-switch 0x1f
        :pswitch_4a
        :pswitch_3a
        :pswitch_2a
    .end packed-switch
.end method
