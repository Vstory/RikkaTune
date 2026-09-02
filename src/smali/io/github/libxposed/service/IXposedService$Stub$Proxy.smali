.class final Lio/github/libxposed/service/IXposedService$Stub$Proxy;
.super Ljava/lang/Object;
.source "IXposedService.java"
.implements Lio/github/libxposed/service/IXposedService;
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/github/libxposed/service/IXposedService$Stub;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Proxy"
.end annotation
.field private mRemote:Landroid/os/IBinder;
.method constructor <init>(Landroid/os/IBinder;)V
    .registers 2
    .line 271
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    .line 272
    iput-object p1, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    return-void
.end method
.method public asBinder()Landroid/os/IBinder;
    .registers 1
    .line 276
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    return-object p0
.end method
.method public deleteRemoteFile(Ljava/lang/String;)Z
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 548
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 549
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 552
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 553
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    .line 554
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p1, 0x21
    const/4 v2, 0x0
    invoke-interface {p0, p1, v0, v1, v2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 555
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 556
    invoke-virtual {v1}, Landroid/os/Parcel;->readInt()I
    move-result p0
    :try_end_1f
    .catchall {:try_start_8 .. :try_end_1f} :catchall_29
    if-eqz p0, :cond_22
    const/4 v2, 0x1
    .line 559
    :cond_22
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 560
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return v2
    :catchall_29
    move-exception p0
    .line 559
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 560
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 561
    throw p0
.end method
.method public deleteRemotePreferences(Ljava/lang/String;)V
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 497
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 498
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 500
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 501
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    .line 502
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p1, 0x17
    const/4 v2, 0x0
    invoke-interface {p0, p1, v0, v1, v2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 503
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 506
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 507
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-void
    :catchall_22
    move-exception p0
    .line 506
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 507
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 508
    throw p0
.end method
.method public getApiVersion()I
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 285
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 286
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 289
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 290
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 v2, 0x2
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 291
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 292
    invoke-virtual {v1}, Landroid/os/Parcel;->readInt()I
    move-result p0
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 295
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 296
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return p0
    :catchall_22
    move-exception p0
    .line 295
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 296
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 297
    throw p0
.end method
.method public getFrameworkName()Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 302
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 303
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 306
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 307
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 v2, 0x3
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 308
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 309
    invoke-virtual {v1}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    move-result-object p0
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 312
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 313
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_22
    move-exception p0
    .line 312
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 313
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 314
    throw p0
.end method
.method public getFrameworkProperties()J
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 353
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 354
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 357
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 358
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 v2, 0x6
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 359
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 360
    invoke-virtual {v1}, Landroid/os/Parcel;->readLong()J
    move-result-wide v2
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 363
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 364
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-wide v2
    :catchall_22
    move-exception p0
    .line 363
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 364
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 365
    throw p0
.end method
.method public getFrameworkVersion()Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 319
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 320
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 323
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 324
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 v2, 0x4
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 325
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 326
    invoke-virtual {v1}, Landroid/os/Parcel;->readString()Ljava/lang/String;
    move-result-object p0
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 329
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 330
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_22
    move-exception p0
    .line 329
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 330
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 331
    throw p0
.end method
.method public getFrameworkVersionCode()J
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 336
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 337
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 340
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 341
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 v2, 0x5
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 342
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 343
    invoke-virtual {v1}, Landroid/os/Parcel;->readLong()J
    move-result-wide v2
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 346
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 347
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-wide v2
    :catchall_22
    move-exception p0
    .line 346
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 347
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 348
    throw p0
.end method
.method public final getInterfaceDescriptor()Ljava/lang/String;
    .registers 1
    .line 280
    const-string p0, "io.github.libxposed.service.IXposedService"
    return-object p0
.end method
.method public getRunningTargets()Ljava/util/List;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/github/libxposed/service/HookedProcess;",
            ">;"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 420
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 421
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 424
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 425
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 v2, 0xe
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 426
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 427
    sget-object p0, Lio/github/libxposed/service/HookedProcess;->CREATOR:Landroid/os/Parcelable$Creator;
    invoke-virtual {v1, p0}, Landroid/os/Parcel;->createTypedArrayList(Landroid/os/Parcelable$Creator;)Ljava/util/ArrayList;
    move-result-object p0
    :try_end_1e
    .catchall {:try_start_8 .. :try_end_1e} :catchall_25
    .line 430
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 431
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_25
    move-exception p0
    .line 430
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 431
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 432
    throw p0
.end method
.method public getScope()Ljava/util/List;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 371
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 372
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 375
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 376
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 v2, 0xb
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 377
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 378
    invoke-virtual {v1}, Landroid/os/Parcel;->createStringArrayList()Ljava/util/ArrayList;
    move-result-object p0
    :try_end_1c
    .catchall {:try_start_8 .. :try_end_1c} :catchall_23
    .line 381
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 382
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_23
    move-exception p0
    .line 381
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 382
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 383
    throw p0
.end method
.method public hotReloadModule(JLandroid/os/Bundle;Lio/github/libxposed/service/IHotReloadCallback;)V
    .registers 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 445
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 446
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 448
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 449
    invoke-virtual {v0, p1, p2}, Landroid/os/Parcel;->writeLong(J)V
    const/4 p1, 0x0
    .line 450
    invoke-static {v0, p3, p1}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smwriteTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    .line 451
    invoke-virtual {v0, p4}, Landroid/os/Parcel;->writeStrongInterface(Landroid/os/IInterface;)V
    .line 452
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p2, 0xf
    invoke-interface {p0, p2, v0, v1, p1}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 453
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    :try_end_21
    .catchall {:try_start_8 .. :try_end_21} :catchall_28
    .line 456
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 457
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-void
    :catchall_28
    move-exception p0
    .line 456
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 457
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 458
    throw p0
.end method
.method public listRemoteFiles()[Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 513
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 514
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 517
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 518
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 v2, 0x1f
    const/4 v3, 0x0
    invoke-interface {p0, v2, v0, v1, v3}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 519
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 520
    invoke-virtual {v1}, Landroid/os/Parcel;->createStringArray()[Ljava/lang/String;
    move-result-object p0
    :try_end_1c
    .catchall {:try_start_8 .. :try_end_1c} :catchall_23
    .line 523
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 524
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_23
    move-exception p0
    .line 523
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 524
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 525
    throw p0
.end method
.method public openRemoteFile(Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 530
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 531
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 534
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 535
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    .line 536
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p1, 0x20
    const/4 v2, 0x0
    invoke-interface {p0, p1, v0, v1, v2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 537
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 538
    sget-object p0, Landroid/os/ParcelFileDescriptor;->CREATOR:Landroid/os/Parcelable$Creator;
    invoke-static {v1, p0}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smreadTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    move-result-object p0
    check-cast p0, Landroid/os/ParcelFileDescriptor;
    :try_end_23
    .catchall {:try_start_8 .. :try_end_23} :catchall_2a
    .line 541
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 542
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_2a
    move-exception p0
    .line 541
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 542
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 543
    throw p0
.end method
.method public removeScope(Ljava/util/List;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 401
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 402
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 404
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 405
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V
    .line 406
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p1, 0xd
    const/4 v2, 0x0
    invoke-interface {p0, p1, v0, v1, v2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 407
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_22
    .line 410
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 411
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-void
    :catchall_22
    move-exception p0
    .line 410
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 411
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 412
    throw p0
.end method
.method public requestRemotePreferences(Ljava/lang/String;)Landroid/os/Bundle;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 463
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 464
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 467
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 468
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    .line 469
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p1, 0x15
    const/4 v2, 0x0
    invoke-interface {p0, p1, v0, v1, v2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 470
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    .line 471
    sget-object p0, Landroid/os/Bundle;->CREATOR:Landroid/os/Parcelable$Creator;
    invoke-static {v1, p0}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smreadTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable$Creator;)Ljava/lang/Object;
    move-result-object p0
    check-cast p0, Landroid/os/Bundle;
    :try_end_23
    .catchall {:try_start_8 .. :try_end_23} :catchall_2a
    .line 474
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 475
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-object p0
    :catchall_2a
    move-exception p0
    .line 474
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 475
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 476
    throw p0
.end method
.method public requestScope(Ljava/util/List;Lio/github/libxposed/service/IXposedScopeCallback;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lio/github/libxposed/service/IXposedScopeCallback;",
            ")V"
        }
    .end annotation
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 388
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 390
    :try_start_4
    const-string v1, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v1}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 391
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeStringList(Ljava/util/List;)V
    .line 392
    invoke-virtual {v0, p2}, Landroid/os/Parcel;->writeStrongInterface(Landroid/os/IInterface;)V
    .line 393
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/4 p1, 0x0
    const/4 p2, 0x1
    const/16 v1, 0xc
    invoke-interface {p0, v1, v0, p1, p2}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    :try_end_18
    .catchall {:try_start_4 .. :try_end_18} :catchall_1c
    .line 396
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-void
    :catchall_1c
    move-exception p0
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 397
    throw p0
.end method
.method public updateRemotePreferences(Ljava/lang/String;Landroid/os/Bundle;)V
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
    .line 481
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v0
    .line 482
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;
    move-result-object v1
    .line 484
    :try_start_8
    const-string v2, "io.github.libxposed.service.IXposedService"
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V
    .line 485
    invoke-virtual {v0, p1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V
    const/4 p1, 0x0
    .line 486
    invoke-static {v0, p2, p1}, Lio/github/libxposed/service/IXposedService$_Parcel;->-$$Nest$smwriteTypedObject(Landroid/os/Parcel;Landroid/os/Parcelable;I)V
    .line 487
    iget-object p0, p0, Lio/github/libxposed/service/IXposedService$Stub$Proxy;->mRemote:Landroid/os/IBinder;
    const/16 p2, 0x16
    invoke-interface {p0, p2, v0, v1, p1}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z
    .line 488
    invoke-virtual {v1}, Landroid/os/Parcel;->readException()V
    :try_end_1e
    .catchall {:try_start_8 .. :try_end_1e} :catchall_25
    .line 491
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 492
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    return-void
    :catchall_25
    move-exception p0
    .line 491
    invoke-virtual {v1}, Landroid/os/Parcel;->recycle()V
    .line 492
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    .line 493
    throw p0
.end method
