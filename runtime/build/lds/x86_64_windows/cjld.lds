/* Default linker script, for normal executables */

OUTPUT_FORMAT(pei-x86-64)
SEARCH_DIR("/r/winlibs64_stage/20272.binutils/inst_binutils-2.38/share/binutils/x86_64-w64-mingw32/lib"); SEARCH_DIR("/r/winlibs64_stage/20272.binutils/inst_binutils-2.38/share/binutils/lib"); SEARCH_DIR("/usr/local/lib"); SEARCH_DIR("/lib"); SEARCH_DIR("/usr/lib");
SECTIONS
{
  /* Make the virtual address and file offset synced if the alignment is
     lower than the target page size. */
  . = SIZEOF_HEADERS;
  . = ALIGN(__section_alignment__);
  .text  __image_base__ + ( __section_alignment__ < 0x1000 ? . : __section_alignment__ ) :
  {
    KEEP (*(SORT_NONE(.init)))
    *(.text)
    *(SORT(.text$*))
     *(.text.*)
    /* .cjinit_function sections follows the text section. */
    *(.cjinit_function .cjinit_function.*)
     *(.gnu.linkonce.t.*)
    *(.glue_7t)
    *(.glue_7)
    . = ALIGN(8);
       /* Note: we always define __CTOR_LIST__ and ___CTOR_LIST__ here,
          we do not PROVIDE them.  This is because the ctors.o startup
          code in libgcc defines them as common symbols, with the
          expectation that they will be overridden by the definitions
          here.  If we PROVIDE the symbols then they will not be
          overridden and global constructors will not be run.
          See PR 22762 for more details.

          This does mean that it is not possible for a user to define
          their own __CTOR_LIST__ and __DTOR_LIST__ symbols; if they do,
          the content from those variables are included but the symbols
          defined here silently take precedence.  If they truly need to
          be redefined, a custom linker script will have to be used.
          (The custom script can just be a copy of this script with the
          PROVIDE() qualifiers added).
          In particular this means that ld -Ur does not work, because
          the proper __CTOR_LIST__ set by ld -Ur is overridden by a
          bogus __CTOR_LIST__ set by the final link.  See PR 46.  */
       ___CTOR_LIST__ = .;
       __CTOR_LIST__ = .;
       LONG (-1); LONG (-1);
       KEEP (*(.ctors));
       KEEP (*(.ctor));
       KEEP (*(SORT_BY_NAME(.ctors.*)));
       LONG (0); LONG (0);
       /* See comment about __CTOR_LIST__ above.  The same reasoning
          applies here too.  */
       ___DTOR_LIST__ = .;
       __DTOR_LIST__ = .;
       LONG (-1); LONG (-1);
       KEEP (*(.dtors));
       KEEP (*(.dtor));
       KEEP (*(SORT_BY_NAME(.dtors.*)));
       LONG (0); LONG (0);
    KEEP (*(SORT_NONE(.fini)))
    /* ??? Why is .gcc_exc here?  */
     *(.gcc_exc)
    PROVIDE (etext = .);
     KEEP (*(.gcc_except_table))
  }
  /* The Cygwin32 library uses a section to avoid copying certain data
     on fork.  This used to be named ".data".  The linker used
     to include this between __data_start__ and __data_end__, but that
     breaks building the cygwin32 dll.  Instead, we name the section
     ".data_cygwin_nocopy" and explicitly include it after __data_end__. */
  .data BLOCK(__section_alignment__) :
  {
    __data_start__ = . ;
    *(.data)
    *(.data2)
    *(SORT(.data$*))
    KEEP(*(.jcr))
    __data_end__ = . ;
    *(.data_cygwin_nocopy)
    PROVIDE_HIDDEN(__CJMetadataStart = .);
    *cjstart.o(.cjmetadata.rw.header)

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJSDKVersion = .);
    *(.cjmetadata.sdk.version)
    *(SORT(.cjmetadata.sdk.version.*))
    PROVIDE_HIDDEN(__CJSDKVersionEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJMethodInfo = .);
    *(.cjmetadata.methodinfo)
    *(SORT(.cjmetadata.methodinfo.*))
    PROVIDE_HIDDEN(__CJMethodInfoEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJGlobalInitFunc = .);
    KEEP(*(.cjmetadata.globalInitFunc))
    PROVIDE_HIDDEN(__CJGlobalInitFuncEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJStringPoolDict = .);
    KEEP(*(.cjmetadata.stringpooldict))
    PROVIDE_HIDDEN(__CJStringPoolDictEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJStringPool = .);
    KEEP(*(.cjmetadata.stringpool))
    PROVIDE_HIDDEN(__CJStringPoolEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJStackMap = .);
    *(.cjmetadata.stackmap)
    PROVIDE_HIDDEN(__CJStackMapEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJGCTib = .);
    *(.cjmetadata.gctib)
    PROVIDE_HIDDEN(__CJGCTibEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJGCRoots = .);
    *(.cjmetadata.gcroots)
    PROVIDE_HIDDEN(__CJGCRootsEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJTypeTemplate = .);
    *(.cjmetadata.typetemplate*)
    PROVIDE_HIDDEN(__CJTypeTemplateEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJTypeInfo = .);
    *(.cjmetadata.typeinfo*)
    PROVIDE_HIDDEN(__CJTypeInfoEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJTypeFields = .);
    *(.cjmetadata.type.fields*)
    PROVIDE_HIDDEN(__CJTypeFieldsEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJMTable = .);
    *(.cjmetadata.mtable)
    PROVIDE_HIDDEN(__CJMTableEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJInnerTypeExtensions = .);
    *(.cjmetadata.innerty.eds)
    PROVIDE_HIDDEN(__CJInnerTypeExtensionsEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJOuterTypeExtensions = .);
    *(.cjmetadata.outerty.eds)
    PROVIDE_HIDDEN(__CJOuterTypeExtensionsEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJStaticGITable = .);
    KEEP(*(.cjmetadata.static.generic.ti))
    PROVIDE_HIDDEN(__CJStaticGITableEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJGCFlags = .);
    KEEP(*(.cjmetadata.gcflags))
    PROVIDE_HIDDEN(__CJGCFlagsEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJReflectPkgInfo = .);
    KEEP(*(.cjmetadata.reflect.pkginfo*))
    PROVIDE_HIDDEN(__CJReflectPkgInfoEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJReflectGV = .);
    KEEP(*(.cjmetadata.reflect.gv*))
    PROVIDE_HIDDEN(__CJReflectGVEnd = .);

    . = ALIGN(16);
    PROVIDE_HIDDEN(__CJReflectGI = .);
    KEEP(*(.cjmetadata.reflect.generic.ti*))
    PROVIDE_HIDDEN(__CJReflectGIEnd = .);
    __CJMetadataEnd = .;

    PROVIDE_HIDDEN(__CJMetadataEnd = .);
  }
  PROVIDE_HIDDEN(__CJMethodInfoSize = __CJMethodInfoEnd - __CJMethodInfo);
  PROVIDE_HIDDEN(__CJGlobalInitFuncSize = __CJGlobalInitFuncEnd - __CJGlobalInitFunc);
  PROVIDE_HIDDEN(__CJStringPoolDictSize = __CJStringPoolDictEnd - __CJStringPoolDict);
  PROVIDE_HIDDEN(__CJStringPoolSize = __CJStringPoolEnd - __CJStringPool);
  PROVIDE_HIDDEN(__CJStackMapSize   = __CJStackMapEnd - __CJStackMap);
  PROVIDE_HIDDEN(__CJGCTibSize      = __CJGCTibEnd - __CJGCTib);
  PROVIDE_HIDDEN(__CJGCRootsSize    = __CJGCRootsEnd - __CJGCRoots);
  PROVIDE_HIDDEN(__CJTypeTemplateSize  = __CJTypeTemplateEnd - __CJTypeTemplate);
  PROVIDE_HIDDEN(__CJTypeInfoSize  = __CJTypeInfoEnd - __CJTypeInfo);
  PROVIDE_HIDDEN(__CJTypeFieldsSize  = __CJTypeFieldsEnd - __CJTypeFields);
  PROVIDE_HIDDEN(__CJMTableSize     = __CJMTableEnd - __CJMTable);
  PROVIDE_HIDDEN(__CJInnerTypeExtensionsSize = __CJInnerTypeExtensionsEnd - __CJInnerTypeExtensions);
  PROVIDE_HIDDEN(__CJOuterTypeExtensionsSize = __CJOuterTypeExtensionsEnd - __CJOuterTypeExtensions);
  PROVIDE_HIDDEN(__CJStaticGITableSize = __CJStaticGITableEnd - __CJStaticGITable);
  PROVIDE_HIDDEN(__CJGCFlagsSize = __CJGCFlagsEnd - __CJGCFlags);
  PROVIDE_HIDDEN(__CJGCReflectPkgInfoSize = __CJReflectPkgInfoEnd - __CJReflectPkgInfo);
  PROVIDE_HIDDEN(__CJReflectGVSize = __CJReflectGVEnd - __CJReflectGV);
  PROVIDE_HIDDEN(__CJReflectGISize = __CJReflectGIEnd - __CJReflectGI);
  PROVIDE_HIDDEN(__CJMetadataSize = __CJMetadataEnd - __CJMetadataStart);
  /* Cangjie Metadata sections end */
  .rdata BLOCK(__section_alignment__) :
  {
    *(.rdata)
             *(SORT(.rdata$*))
    . = ALIGN(4);
    __rt_psrelocs_start = .;
    KEEP(*(.rdata_runtime_pseudo_reloc))
    __rt_psrelocs_end = .;
  }
  __rt_psrelocs_size = __rt_psrelocs_end - __rt_psrelocs_start;
  ___RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
  __RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
  ___RUNTIME_PSEUDO_RELOC_LIST__ = . - __rt_psrelocs_size;
  __RUNTIME_PSEUDO_RELOC_LIST__ = . - __rt_psrelocs_size;
  .eh_frame BLOCK(__section_alignment__) :
  {
    KEEP (*(.eh_frame*))
  }
  .pdata BLOCK(__section_alignment__) :
  {
    KEEP(*(.pdata*))
  }
  .xdata BLOCK(__section_alignment__) :
  {
    KEEP(*(.xdata*))
  }
  .bss BLOCK(__section_alignment__) :
  {
    __bss_start__ = . ;
    *(.bss)
    *(COMMON)
    __bss_end__ = . ;
  }
  .edata BLOCK(__section_alignment__) :
  {
    *(.edata)
  }
  /DISCARD/ :
  {
    *(.debug$S)
    *(.debug$T)
    *(.debug$F)
    *(.drectve)
     *(.note.GNU-stack)
     *(.gnu.lto_*)
  }
  .idata BLOCK(__section_alignment__) :
  {
    /* This cannot currently be handled with grouped sections.
        See pep.em:sort_sections.  */
    KEEP (SORT(*)(.idata$2))
    KEEP (SORT(*)(.idata$3))
    /* These zeroes mark the end of the import list.  */
    LONG (0); LONG (0); LONG (0); LONG (0); LONG (0);
    KEEP (SORT(*)(.idata$4))
    __IAT_start__ = .;
    SORT(*)(.idata$5)
    __IAT_end__ = .;
    KEEP (SORT(*)(.idata$6))
    KEEP (SORT(*)(.idata$7))
  }
  .CRT BLOCK(__section_alignment__) :
  {
    ___crt_xc_start__ = . ;
    KEEP (*(SORT(.CRT$XC*)))  /* C initialization */
    ___crt_xc_end__ = . ;
    ___crt_xi_start__ = . ;
    KEEP (*(SORT(.CRT$XI*)))  /* C++ initialization */
    ___crt_xi_end__ = . ;
    ___crt_xl_start__ = . ;
    KEEP (*(SORT(.CRT$XL*)))  /* TLS callbacks */
    /* ___crt_xl_end__ is defined in the TLS Directory support code */
    ___crt_xp_start__ = . ;
    KEEP (*(SORT(.CRT$XP*)))  /* Pre-termination */
    ___crt_xp_end__ = . ;
    ___crt_xt_start__ = . ;
    KEEP (*(SORT(.CRT$XT*)))  /* Termination */
    ___crt_xt_end__ = . ;
  }
  /* Windows TLS expects .tls$AAA to be at the start and .tls$ZZZ to be
     at the end of the .tls section.  This is important because _tls_start MUST
     be at the beginning of the section to enable SECREL32 relocations with TLS
     data.  */
  .tls BLOCK(__section_alignment__) :
  {
    ___tls_start__ = . ;
    KEEP (*(.tls$AAA))
    KEEP (*(.tls))
    KEEP (*(.tls$))
    KEEP (*(SORT(.tls$*)))
    KEEP (*(.tls$ZZZ))
    ___tls_end__ = . ;
  }
  .endjunk BLOCK(__section_alignment__) :
  {
    /* end is deprecated, don't use it */
    PROVIDE (end = .);
    PROVIDE ( _end = .);
     __end__ = .;
  }
  .rsrc BLOCK(__section_alignment__) : SUBALIGN(4)
  {
    KEEP (*(.rsrc))
    KEEP (*(.rsrc$*))
  }
  .reloc BLOCK(__section_alignment__) :
  {
    *(.reloc)
  }
  .stab BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.stab)
  }
  .stabstr BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.stabstr)
  }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section.  Unlike other targets that fake this by putting the
     section VMA at 0, the PE format will not allow it.  */
  /* DWARF 1.1 and DWARF 2.  */
  .debug_aranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_aranges)
  }
  .zdebug_aranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_aranges)
  }
  .debug_pubnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_pubnames)
  }
  .zdebug_pubnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_pubnames)
  }
  /* DWARF 2.  */
  .debug_info BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_info .gnu.linkonce.wi.*)
  }
  .zdebug_info BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_info .zdebug.gnu.linkonce.wi.*)
  }
  .debug_abbrev BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_abbrev)
  }
  .zdebug_abbrev BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_abbrev)
  }
  .debug_line BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_line)
  }
  .zdebug_line BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_line)
  }
  .debug_frame BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_frame*)
  }
  .zdebug_frame BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_frame*)
  }
  .debug_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_str)
  }
  .zdebug_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_str)
  }
  .debug_loc BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_loc)
  }
  .zdebug_loc BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_loc)
  }
  .debug_macinfo BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_macinfo)
  }
  .zdebug_macinfo BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_macinfo)
  }
  /* SGI/MIPS DWARF 2 extensions.  */
  .debug_weaknames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_weaknames)
  }
  .zdebug_weaknames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_weaknames)
  }
  .debug_funcnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_funcnames)
  }
  .zdebug_funcnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_funcnames)
  }
  .debug_typenames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_typenames)
  }
  .zdebug_typenames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_typenames)
  }
  .debug_varnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_varnames)
  }
  .zdebug_varnames BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_varnames)
  }
  /* DWARF 3.  */
  .debug_pubtypes BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_pubtypes)
  }
  .zdebug_pubtypes BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_pubtypes)
  }
  .debug_ranges BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_ranges)
  }
  .zdebug_ranges BLOCK(__section_alignment__) (NOLOAD) :
  {
  }
  /* DWARF 4.  */
  .debug_types BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_types .gnu.linkonce.wt.*)
  }
  .zdebug_types BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_types .gnu.linkonce.wt.*)
  }
  /* DWARF 5.  */
  .debug_addr BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_addr)
  }
  .zdebug_addr BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_addr)
  }
  .debug_line_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_line_str)
  }
  .zdebug_line_str BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_line_str)
  }
  .debug_loclists BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_loclists)
  }
  .zdebug_loclists BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_loclists)
  }
  .debug_macro BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_macro)
  }
  .zdebug_macro BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_macro)
  }
  .debug_names BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_names)
  }
  .zdebug_names BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_names)
  }
  .debug_rnglists BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_rnglists)
  }
  .zdebug_rnglists BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_rnglists)
  }
  .debug_str_offsets BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_str_offsets)
  }
  .zdebug_str_offsets BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_str_offsets)
  }
  .debug_sup BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_sup)
  }
  .debug_gdb_scripts BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.debug_gdb_scripts)
  }
  .zdebug_gdb_scripts BLOCK(__section_alignment__) (NOLOAD) :
  {
    *(.zdebug_gdb_scripts)
  }
}
